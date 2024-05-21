//
//  DownloadManager.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/17/24.
//

import Foundation
import Combine

class DownloadManager: ObservableObject {
    static let shared = DownloadManager()

    @Published var isDownloading = false
    @Published var downloadProgress: Float = 0.0
    @Published var downloadedFileURL: URL?

    private var cancellables = Set<AnyCancellable>()

    func downloadFile(from urlString: String, fileName: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }

        // Handle local file URLs directly
        if url.isFileURL {
            let destinationURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
            do {
                try FileManager.default.copyItem(at: url, to: destinationURL)
                self.downloadedFileURL = destinationURL
                print("File copied successfully to \(destinationURL)")
            } catch {
                print("Copying local file failed with error: \(error)")
            }
            return
        }

        // Handle remote file URLs using URLSession
        isDownloading = true
        downloadProgress = 0.0
        let destinationURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> URL in
                try data.write(to: destinationURL)
                return destinationURL
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isDownloading = false
                if case .failure(let error) = completion {
                    print("Download failed with error: \(error)")
                }
            }, receiveValue: { fileURL in
                self.downloadedFileURL = fileURL
                self.isDownloading = false
            })
            .store(in: &cancellables)
    }
}


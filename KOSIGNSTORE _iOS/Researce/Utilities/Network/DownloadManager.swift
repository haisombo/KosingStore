//
//  DownloadManager.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/17/24.
//

import Foundation

class DownloadManager: ObservableObject {
    
    static let shared                   = DownloadManager()
    @Published var downloadedFileURL    : URL?
    @Published var isDownloading        = false
    @Published var downloadProgress     : Float = 0.0

    func downloadFile(from urlString: String, fileName: String) {
        guard let url = URL(string: urlString) else { return }
        
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsPath.appendingPathComponent(fileName)
        
        let task = URLSession.shared.downloadTask(with: url) { tempURL, response, error in
            guard let tempURL = tempURL, error == nil else { return }
            do {
                try FileManager.default.moveItem(at: tempURL, to: fileURL)
                DispatchQueue.main.async {
                    self.downloadedFileURL = fileURL
                    self.isDownloading = false
                }
            } catch {
                print("File move error: \(error)")
            }
        }
        
        task.resume()
    }
}



////
////  DownloadManager.swift
////  KOSIGNStore
////
////  Created by Hai Sombo on 5/17/24.
////
//
//import Foundation
//
//class DownloadManager: ObservableObject {
//    static let shared = DownloadManager()
//    
//    @Published var downloadProgress: Float = 0.0
//    @Published var isDownloading: Bool = false
//    @Published var downloadFinished: Bool = false
//    @Published var downloadedFilePath: URL?
//
//    func downloadFile(from urlString: String, to destinationFileName: String) {
//        guard let url = URL(string: urlString) else { return }
//
//        self.isDownloading = true
//        self.downloadFinished = false
//        
//        let task = URLSession.shared.downloadTask(with: url) { [weak self] (tempFileUrl, response, error) in
//            guard let self = self else { return }
//            
//            if let tempFileUrl = tempFileUrl, error == nil {
//                do {
//                    let fileManager = FileManager.default
//                    let cachesDirectoryUrl = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
//                    let destinationUrl = cachesDirectoryUrl.appendingPathComponent(destinationFileName)
//                    
//                    if fileManager.fileExists(atPath: destinationUrl.path) {
//                        try fileManager.removeItem(at: destinationUrl)
//                    }
//                    
//                    try fileManager.moveItem(at: tempFileUrl, to: destinationUrl)
//                    
//                    DispatchQueue.main.async {
//                        self.downloadProgress = 1.0
//                        self.isDownloading = false
//                        self.downloadFinished = true
//                        self.downloadedFilePath = destinationUrl
//                    }
//                    
//                } catch {
//                    print("Error saving file: \(error)")
//                }
//            } else {
//                DispatchQueue.main.async {
//                    self.isDownloading = false
//                }
//                if let error = error {
//                    print("Download error: \(error)")
//                }
//            }
//        }
//        
//        task.resume()
//    }
//}
//

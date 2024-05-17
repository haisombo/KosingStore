//
//  PDFViewer.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/17/24.
//

import SwiftUI

struct PDFViewer: View {
    let pdfName: String
    var body: some View {
        
        // For View Data -->  (file)
        PDFKitView(pdfName: pdfName)
            .navigationBarTitle(Text(pdfName), displayMode: .inline)
    }
}

////
////  PDFViewer.swift
////  KOSIGNStore
////
////  Created by Hai Sombo on 5/17/24.
////
//
//import SwiftUI
//
//
//struct ContentView: View {
//
//    @ObservedObject var downloadManager = DownloadManager.shared
//    @State private var showPDFViewer = false
//
//        let remotePDFUrlString = "https://example.com/yourfile.pdf"
//        let localPDFFileName = "DownloadedFile.pdf"
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                NavigationLink(destination: PDFViewer(pdfName: "32nd-TOPIK-Papers-Intermediate")) {
//                    Text("View Local PDF")
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//
//                Button("Download ") {
//                    print("sjfbdskfbdsz")
//                                  downloadManager.downloadFile(from: remotePDFUrlString, to: localPDFFileName)
//                              }
//                              .padding()
//                              .background(Color.blue)
//                              .foregroundColor(.white)
//                              .cornerRadius(8)
//
//                              if downloadManager.isDownloading {
//
//                                  ProgressView(value: downloadManager.downloadProgress)
//                                      .padding()
//                              }
//
//                              if downloadManager.downloadFinished, let filePath = downloadManager.downloadedFilePath {
//                                  NavigationLink(destination: PDFViewer(pdfName: filePath.path ) /*PDFKitView(pdfName: filePath)*/, isActive: $showPDFViewer) {
//                                      EmptyView()
//                                  }
//                                  .hidden()
//
//                                  Button("View PDF") {
//                                      showPDFViewer = true
//                                  }
//                                  .padding()
//                                  .background(Color.green)
//                                  .foregroundColor(.white)
//                                  .cornerRadius(8)
//                              }
//
//
//
//            }
//
//            .navigationBarTitle("PDF Viewer Example", displayMode: .inline)
//        }
//    }
//}
//
//struct PPTXViewer: View {
//    let pptxUrlString: String
//    @State private var showWebView = false
//    @State private var localFileURL: URL?
//
//    var body: some View {
//        VStack {
//            Button("Download and View PPTX") {
//                downloadFile(from: pptxUrlString)
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(8)
//
//            if let fileURL = localFileURL {
//                NavigationLink(destination: WebView(url: fileURL), isActive: $showWebView) {
//                    EmptyView()
//                }
//                .hidden()
//
//                Button("View PPTX") {
//                    showWebView = true
//                }
//                .padding()
//                .background(Color.green)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//            }
//        }
//        .navigationBarTitle("PPTX Viewer", displayMode: .inline)
//    }
//
//    private func downloadFile(from urlString: String) {
//        guard let url = URL(string: urlString) else { return }
//
//        let task = URLSession.shared.downloadTask(with: url) { (tempFileUrl, response, error) in
//            if let tempFileUrl = tempFileUrl, error == nil {
//                do {
//                    let fileManager = FileManager.default
//                    let cachesDirectoryUrl = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
//                    let destinationUrl = cachesDirectoryUrl.appendingPathComponent(url.lastPathComponent)
//
//                    if fileManager.fileExists(atPath: destinationUrl.path) {
//                        try fileManager.removeItem(at: destinationUrl)
//                    }
//
//                    try fileManager.moveItem(at: tempFileUrl, to: destinationUrl)
//
//                    DispatchQueue.main.async {
//                        self.localFileURL = destinationUrl
//                    }
//
//                } catch {
//                    print("Error saving file: \(error)")
//                }
//            } else {
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
////struct PDFViewer: View  , DownloadManagerDelegate {
////
////      @State private var viewLocalPDF = false
////      @State private var viewRemotePDF = false
////      @State private var loadingPDF: Bool = false
////      @State private var progressValue: Float = 0.0
////      @ObservedObject var downloadManager = DownloadManager.shared()
////
////    let pdfName = "31st TOPIK Papers Intermediate.pdf"
////    let pdfUrlString = "https://example.com/path/to/your/pdf.pdf"
////
////    var body: some View {
////           NavigationView {
////               ZStack {
////                   VStack {
////
////                       NavigationLink(destination: PDFLocalView(pdfName : pdfName  ), isActive: $viewLocalPDF) {
////                           Button("View Local PDF"){
////                               self.viewLocalPDF = true
////                           }
////                           .padding(.bottom, 20)
////                       }
////                       Button("View Remote PDF"){
//////                           if self.fileExistsInDirectory() {
//////                               self.viewRemotePDF = true
//////                           } else {
//////                               self.downloadPDF(pdfUrlString: self.pdfUrlString)
//////                           }
////                           self.viewRemotePDF = true
////                       }
////
//////                       if self.viewRemotePDF {
//////                           NavigationLink(destination: PDFViewer(pdfUrlString: self.pdfUrlString), isActive: self.$viewRemotePDF) {
//////                               EmptyView()
//////                           }.hidden()
//////                       }
////
////
////                   }
////                   ProgressView(value: self.$progressValue, visible: self.$loadingPDF)
////               }
////               .navigationBarTitle("PDFViewer", displayMode: .inline)
////           }
////       }
////
////       private func fileExistsInDirectory() -> Bool {
////           if let cachesDirectoryUrl =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first, let lastPathComponent = URL(string: self.pdfUrlString)?.lastPathComponent {
////               let url = cachesDirectoryUrl.appendingPathComponent(lastPathComponent)
////               if FileManager.default.fileExists(atPath: url.path) {
////                   return true
////               }
////           }
////           return false
////       }
////
////       private func downloadPDF(pdfUrlString: String) {
////           guard let url = URL(string: pdfUrlString) else { return }
////           downloadManager.delegate = self
////           downloadManager.downloadFile(url: url)
////       }
////
////       //MARK: DownloadManagerDelegate
////       func downloadDidFinished(success: Bool) {
////           if success {
////               loadingPDF = false
////               viewRemotePDF = true
////           }
////       }
////
////       func downloadDidFailed(failure: Bool) {
////           if failure {
////               loadingPDF = false
////               print("PDFCatalogueView: Download failure")
////           }
////       }
////
////       func downloadInProgress(progress: Float, totalBytesWritten: Float, totalBytesExpectedToWrite: Float) {
////           loadingPDF = true
////           progressValue = progress
////       }
////}
//// Placeholder for PDFLocalView
//struct PDFLocalView: View {
//    let pdfName: String
//
//    var body: some View {
//        Text("Displaying local PDF: \(pdfName)")
//    }
//}
//
//
//#Preview {
//    ContentView()
////    PPTXViewer(pptxUrlString: "https://example.com/yourfile.pptx")
//}

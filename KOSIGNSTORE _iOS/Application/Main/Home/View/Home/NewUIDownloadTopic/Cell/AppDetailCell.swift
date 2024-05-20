//
//  AppDetailCell.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/17/24.
//

import SwiftUI
import  FittedSheetsSwiftUI

struct AppDetailCell: View {
    
    @ObservedObject var downloadManager     = DownloadManager.shared
    @State private  var showPDFViewer       = false
    @State private  var selection: String?  = nil
    @State          var listAppVersion      : AppDetail? = nil
    @State private  var showShareSheet      = false
    let remotePDFUrlString                  = "https://example.com/yourfile.pdf"
    let localPDFFileName                    = "DownloadedFile.pdf"
    
    let sheetConfiguration: SheetConfiguration = SheetConfiguration (
        
        sizes: [.marginFromTop(70.0)],
        options: nil,
        sheetViewControllerOptinos: [],
        shouldDismiss: nil,
        didDismiss: nil)

    var body: some View {
        VStack (alignment : .leading ,spacing : 20 )  {
            VStack  (alignment : .leading , spacing: 20 ){
                HStack {
                    HStack (spacing: 10 ) {
                        Text(listAppVersion?.title ?? "")
                            .font(.customFont(font: .Rubik, style: .medium , size: .h3))
                        Image(listAppVersion?.icon ?? "")
                            .resizable()
                            .frame(width: 30 , height: 30)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                    }) {
                        Image("dropdown")
                        
                    }
                }
            }
            
            HStack  {
                HStack (spacing : 40 ) {
                    // MARK: - Button Real
                    VStack {
                        
                        Button(action: {
                            selection = "read"
                            showPDFViewer = true
                            
                        }, label: {
                            Text("Read")
                                .font(.customFont(font: .Rubik, style: .bold , size: .h4))
                                .foregroundColor(Color.white)
                                .frame(height: 50 )
                                .frame(maxWidth: .infinity)
                                .background(Color ("ColorRead"))
                                .cornerRadius(8.0)
                            
                        })
                        .buttonStyle(PressableButtonStyle())
                        
                        //                            }
                        
                    }
                    // MARK: - Button Download
                    VStack {
                        Button(action: {
//                            downloadManager.downloadFile(from: remotePDFUrlString , fileName: localPDFFileName)
                            
                            downloadManager.downloadFile(from: listAppVersion?.pathFile ?? "", fileName: listAppVersion?.readData ?? "")
                        }, label: {
                            Text("Download")
                                .font(.customFont(font: .Rubik, style: .bold, size: .h4))
                                .foregroundColor(Color.white)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(Color("ColorDownload"))
                                .cornerRadius(8.0)
                            
                            
                        })
                        .buttonStyle(PressableButtonStyle())
                        .onChange(of: downloadManager.downloadedFileURL) { newURL in
                            if newURL != nil {
                                showShareSheet = true
                            }
                        }
                    }
                }
                
            }
            
            
        }
        .fullScreenCover(isPresented: $showPDFViewer) {
            if let localPath = listAppVersion?.pathFile, !localPath.isEmpty {
                PDFViewer(pdfName: listAppVersion?.readData ?? "", fileURL: URL(fileURLWithPath: localPath))
            } else {
                PDFViewer(pdfName: listAppVersion?.readData ?? "", fileURL: downloadManager.downloadedFileURL)
            }
        }

        .fittedSheet(isPresented: $showShareSheet,  configuration: sheetConfiguration )  {
            if let downloadedFileURL = downloadManager.downloadedFileURL {
                ActivityView(activityItems: [downloadedFileURL])
            }
        }
    }
}

struct ActivityView: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}
#Preview {
    AppDetailCell()
}

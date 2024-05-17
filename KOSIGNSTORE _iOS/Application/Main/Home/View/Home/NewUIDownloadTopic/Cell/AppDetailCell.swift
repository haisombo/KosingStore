//
//  AppDetailCell.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/17/24.
//

import SwiftUI
//import PDFViewer
//import PDFKit
//import WebKit

struct AppDetailCell: View {
    
//    @ObservedObject var downloadManager     = DownloadManager.shared
    @State private var showPDFViewer        = false
    let remotePDFUrlString                  = "https://example.com/yourfile.pdf"
    let localPDFFileName                    = "DownloadedFile.pdf"
    @State private var selection: String? = nil

    var body: some View {
//        NavigationView {
            VStack (alignment : .leading ,spacing : 20 )  {
                VStack  (alignment : .leading , spacing: 20 ){
                    HStack {
                        HStack (spacing: 10 ) {
                            Text("24th TOPIK ")
                                .font(.customFont(font: .Rubik, style: .medium , size: .h3))
                            Image("icon_file-pdf")
                                .resizable()
                                .frame(width: 30 , height: 30)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // when need to implement can show data !!!
                        }) {
                            Image("dropdown")
                            
                        }
                    }
                }
                
                HStack  {
                    HStack (spacing : 40 ) {
                        // MARK: - Button Real
                        VStack {
                            /// action
                            NavigationLink(destination: PDFViewer(pdfName: "32nd-TOPIK-Papers-Intermediate") , tag: "read" , selection: $selection ) {
                                Button(action: {
                                    selection = "read"
                                    
                                    print("Read ")
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
                            }
                        }
                        // MARK: - Button Dev
                        VStack {
                            Button(action: {
                                // Action
                                print("Download ")
                            }, label: {
                                Text("Download")
                                    .font(.customFont(font: .Rubik, style: .bold , size: .h4))
                                    .foregroundColor(Color.white)
                                    .frame(height: 50 )
                                    .frame(maxWidth: .infinity)
                                    .background(Color ("ColorDownload"))
                                    .cornerRadius(8.0)
                            })
                            .buttonStyle(PressableButtonStyle())
                            
                        }
                    }
                    
                }
                
            }
    }
}

#Preview {
    AppDetailCell()
}

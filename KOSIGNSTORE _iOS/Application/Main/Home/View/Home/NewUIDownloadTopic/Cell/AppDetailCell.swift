//
//  AppDetailCell.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/17/24.
//

import SwiftUI
import FittedSheetsSwiftUI

struct AppDetailCell: View {
    
    // MARK: - Properties
    
    @State private  var showPDFViewer       = false
    @State private  var selection: String?  = nil
    @State private  var showShareSheet      = false
    @State var listAppVersion      : AppDetail? = nil
    @State var items : [Any] = []
    @AppStorage("signIn") var isSignIn = false
    @State private  var showAlert      = false
    // MARK: - Custom PopSheet
    let sheetConfiguration: SheetConfiguration = SheetConfiguration (
        
        sizes: [.fixed(550)],
        options: nil,
        sheetViewControllerOptinos: [],
        shouldDismiss: nil,
        didDismiss: nil)
    
    // MARK: - BODY
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
                    
                    // MARK: - Action Hide and Show Data Implement
                    Button(action: {
                        // hide and show
                    }) {
                        Image("dropdown")
                    }
                }
            }
            
            HStack  {
                HStack (spacing : 40 ) {
                    // MARK: - Button View FILE.pdf
                    VStack {
                        Button(action: {
                            // call to Screen Viewer
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
                    }
                    // MARK: - Button Download --> FILE.pdf
                    VStack {
                        //check with sign up with google
                        if !isSignIn {
                            Button(action: {
                                self.showAlert = true

                            }, label: {
                                Text("Download")
                                    .font(.customFont(font: .Rubik, style: .bold, size: .h4))
                                    .foregroundColor(Color.white)
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.gray)
                                    .cornerRadius(8.0)
                            })
                            .buttonStyle(PressableButtonStyle())
                         

                            .alert(isPresented: $showAlert, content: { () -> Alert in
                                Alert(title: Text("Error").foregroundColor(Color("NewColor") ), message: Text("Please Login"), dismissButton: .default (
                                    Text("Okay")
                                        .foregroundColor(Color("NewColor"))
                                ))
                            })
                            
                        }else {
                            Button(action: {

                                if let localPath = listAppVersion?.pathFile, !localPath.isEmpty {
                                    let fileName = (localPath as NSString).lastPathComponent
                                    let destinationURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
                                    
                                    // Check if the file already exists
                                    if FileManager.default.fileExists(atPath: destinationURL.path) {
                                        do {
                                            // If file exists, remove it first
                                            try FileManager.default.removeItem(at: destinationURL)
                                        } catch {
                                            
                                            print("Removing existing file failed with error: \(error)")
                                        }
                                    }
                                    do {
                                        let fileURL = URL(fileURLWithPath: localPath)
                                        try FileManager.default.copyItem(at: fileURL, to: destinationURL)
                                        items.append(destinationURL)
                                        showShareSheet.toggle()
                                    } catch {
                                        print("Copying local file failed with error: \(error)")
                                    }
                                }
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
                            

                        }
                    }
                }
            }
        }
        // MARK: - PDF Viwer FILE.pdf
        .fullScreenCover(isPresented: $showPDFViewer) {
            PDFViewer(pdfName: listAppVersion?.readData ?? "", fileURL: URL(fileURLWithPath:  listAppVersion?.pathFile ?? "" ))
        }
        // MARK: - ShareSheet Download --> PDF
        .fittedSheet(isPresented: $showShareSheet, configuration: sheetConfiguration) {
            ShareSheet(item:   items )
        }
    }
}

#Preview {
    AppDetailCell()
}

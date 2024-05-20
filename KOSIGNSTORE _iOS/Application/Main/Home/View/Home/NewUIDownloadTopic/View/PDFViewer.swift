//
//  PDFViewer.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/17/24.
//

import SwiftUI
import PDFKit

struct PDFViewer: View {
    let pdfName: String
    let fileURL: URL?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            if let fileURL = fileURL {
                PDFKitView(url: fileURL)
                    .navigationBarItems(trailing: Button(action: {
                        dismiss()
                    }) {
                        Text("Close")
                            .bold()
                    })
                    .navigationBarTitle(Text(pdfName), displayMode: .inline)
                    .edgesIgnoringSafeArea(.all)
            } else if let bundleURL = Bundle.main.url(forResource: pdfName, withExtension: "pdf") {
                PDFKitView(url: bundleURL)
                    .navigationBarItems(trailing: Button(action: {
                        dismiss()
                    }) {
                        Text("Close")
                            .bold()
                    })
                    .navigationBarTitle(Text(pdfName), displayMode: .inline)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("PDF not found")
                    .navigationBarItems(trailing: Button(action: {
                        dismiss()
                    }) {
                        Text("Close")
                            .bold()
                    })
                    .navigationBarTitle(Text("Error"), displayMode: .inline)
            }
        }
    }
}

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        DispatchQueue.main.async {
            uiView.document = PDFDocument(url: url)
        }
    }
}

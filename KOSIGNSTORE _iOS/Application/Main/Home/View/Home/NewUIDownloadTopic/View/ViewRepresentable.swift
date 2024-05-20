////
////  ViewRepresentable.swift
////  KOSIGNStore
////
////  Created by Hai Sombo on 5/17/24.
////
//
//import SwiftUI
////import PDFViewer
//import PDFKit
//import WebKit
//
//
//struct WebView: UIViewRepresentable {
//    let url: URL
//
//    func makeUIView(context: Context) -> WKWebView {
//        return WKWebView()
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        let request = URLRequest(url: url)
//        uiView.load(request)
//    }
//}
//
//struct PDFKitView: UIViewRepresentable {
//    let pdfName: String
//
//    func makeUIView(context: Context) -> PDFView {
//        let pdfView = PDFView()
//        pdfView.autoScales = true
//        if let url = Bundle.main.url(forResource: pdfName, withExtension: "pdf") {
//            pdfView.document = PDFDocument(url: url)
//        }
//        return pdfView
//    }
//    
//    func updateUIView(_ uiView: PDFView, context: Context) {
//        // Update the view if needed
//    }
//}
//

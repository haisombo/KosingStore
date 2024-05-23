//
//  ViewRepresentable.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/17/24.
//

import SwiftUI

struct ShareSheet : UIViewControllerRepresentable {
    
    // data need share
    var item : [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller  = UIActivityViewController(activityItems: item, applicationActivities: nil)
        return  controller
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
            
    }
    
}

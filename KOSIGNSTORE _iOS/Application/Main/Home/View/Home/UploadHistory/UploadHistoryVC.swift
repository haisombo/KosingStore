//
//  UploadHistoryVC.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/21/24.
//

import SwiftUI

struct UploadHistoryVC: View {
    var body: some View {
        VStack (alignment : .leading) {
            Text("List all user upload and description")
                .font(.customFont(font: .Rubik, style: .bold , size: .h6))
                .foregroundColor(Color("MianColor"))
            
            Divider()
            
            List {
                UploadHistoryCell()
            }
            .scrollContentBackground(.hidden)
            .background(.white)
            .listStyle(.insetGrouped)
        }
    }
}

#Preview {
    UploadHistoryVC()
}

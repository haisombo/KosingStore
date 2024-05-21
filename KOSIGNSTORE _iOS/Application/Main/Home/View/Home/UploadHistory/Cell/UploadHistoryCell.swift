//
//  UploadHistoryCell.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/21/24.
//

import SwiftUI

struct UploadHistoryCell: View {
    @State    private var showData               = false
    
    var body: some View {
        VStack {
            VStack (alignment : .leading ) {
                
                Text("Hai Sombo")
                    .font(.customFont(font: .Rubik, style: .bold , size: .h4))
                    .foregroundColor(Color.black)
                HStack {
                    
                    Text("Modified Date : ")
                        .font(.customFont(font: .Rubik, style: .regular , size: .h6))
                        .foregroundColor(Color.black)
                    Text("2021-02-23 10:12:56.849338")
                        .font(.customFont(font: .Rubik, style: .regular , size: .h6))
                        .foregroundColor(Color.black)
                    Spacer()
                    Button(action: {
                        showData.toggle()
                    }) {
                        if showData {
                            Image("dropdown")
                        } else {
                            Image("dropup")
                        }
                    }
                }
                if showData {
                    VStack (alignment : .leading , spacing:  20 ) {
                        Text("Description")
                            .font(.customFont(font: .Rubik, style: .regular , size: .h6))
                            .foregroundColor(Color("MianColor"))
                        
                        Text("- KOSIGNStore.AnyCodableValue.string)")
                            .font(.customFont(font: .Rubik, style: .regular , size: .h4))
                            .foregroundColor(Color.black)
                    }
              
                } else {
                    
                }
            }
        }
   
    }
}

#Preview {
    UploadHistoryCell()
}

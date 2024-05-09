//
//  HomeDetailVC.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI
import FittedSheetsSwiftUI
import FittedSheets

struct HomeDetailVC: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss

    // MARK: - Body
    var body: some View {
        VStack (alignment: .leading ) {
            HStack (spacing : 20 ) {
                Text ("@KOSIGN")
                    .font(.customFont(font: .Rubik, style: .bold , size: .h5))
                    .foregroundColor(Color("MianColor"))
                // MARK: - Status
                HStack {
                    ReuseStatusUpdateViewPublic(isPublic: true)
                }
                Spacer()
                // cancel button
                HStack {
                    Button(action: {
                        //action
                         dismiss()
                    }) {
                        Image ("cancel")
                            .resizable()
                            .frame(width: 34 , height: 34)
                    }
                }
                
            }.padding(.horizontal , 16)
            
            // MARK: - Content Cell
            VStack (alignment : .leading) {
                HStack {
                    HStack {
                        Image("defaultIMG")
                            .resizable()
                            .frame(width: 50 , height: 50)
                       
                        Text("OpenBoard")
                            .font(.customFont(font: .Rubik, style: .bold , size: .h3))
                    }
                } .padding(.horizontal , 16)
                
                VStack  (alignment : .leading ) {
                    VStack {
                        Text("List of All App's version ")
                            .font(.customFont(font: .Rubik, style: .regular , size: .h4))
                            .foregroundColor(Color("GrayTextColor"))
                    }.padding(.all , 16)
               
                
                // MARK: - List Version Of App Cell
                    VStack  {
                        List {
                            AppVersionDetailViewCell()
                            AppVersionDetailViewCell()
                            AppVersionDetailViewCell()
                            AppVersionDetailViewCell()
                            AppVersionDetailViewCell()
                            AppVersionDetailViewCell()
                        }
                        
                        .listStyle(.inset)
                        .scrollContentBackground(.hidden)
                        .background(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeDetailVC()
}

//
//  HomeDetailVC.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct HomeDetailVC: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack (alignment: .leading ){
            HStack (spacing : 10 ) {
                Text ("@KOSIGN")
                    .font(.customFont(font: .Rubik, style: .bold , size: .h5))
                    .foregroundColor(Color("MianColor"))
                HStack {
                    ReuseStatusUpdateViewNew()
                    ReuseStatusUpdateViewPublic()
                }
                Spacer()
                
                HStack {
                    Button(action: {
                        //action
                         dismiss()
                        
                    }) {
                        Image ("cancel")
                            .resizable()
                            .frame(width: 34 , height: 34)
                      
                    }.padding(.horizontal , 24)
                }
            }
            VStack (alignment : .leading) {
                
                HStack {
                    HStack {
                        Image("defaultIMG")
                            .resizable()
                            .frame(width: 50 , height: 50)
                       
                        Text("OpenBoard")
                            .font(.customFont(font: .Rubik, style: .bold , size: .h3))
                    }.padding(.vertical , 12)
                }
                
                VStack  (alignment : .leading ) {
                    Text("List of All App's version ")
                        .font(.customFont(font: .Rubik, style: .regular , size: .h4))
                        .foregroundColor(Color("GrayTextColor"))
                   
                    VStack  {
                        List (){
                            AppVersionDetailViewCell()
                            AppVersionDetailViewCell()
                            AppVersionDetailViewCell()
                        }       
                        .background(Color.white)
                        .listStyle(GroupedListStyle())

                    }
                }
            }
        }.padding()
        
        
    }
}

#Preview {
    HomeDetailVC()
}

//
//  AppDetailVC.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/17/24.
//

import SwiftUI
import FittedSheetsSwiftUI
import SDWebImageSwiftUI

struct AppDetailVC: View {
    
    @StateObject var appDetailVM = AppDetailVM()

    @Environment(\.dismiss) private var dismiss
    @State private var selection: String? = nil
    
    // MARK: - Body
    var body: some View {
        VStack (alignment: .leading ) {
            HStack (spacing : 20 ) {
                Text("@ Kosign")
                    .font(.customFont(font: .Rubik, style: .bold , size: .h5))
                    .foregroundColor(Color("MianColor"))
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
                        // Profile User
                        WebImage(url: URL(string: "https://kosignstore.wecambodia.com/storage/image/3d8b0319-0a7a-4977-b1d0-84460ef4f906.png" )) { image  in
                            image
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(12)
                        } placeholder: {
                            Image("defaultIMG")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(12)
                        }
                 
                        Text("TOPIK II")
                            .font(.customFont(font: .Rubik, style: .bold , size: .h3))
                    }
                } .padding(.horizontal , 16)
                
                VStack  (alignment : .leading ) {
                    VStack {
                        Text("List of All PDF files ")
                            .font(.customFont(font: .Rubik, style: .regular , size: .h4))
                            .foregroundColor(Color("GrayTextColor"))
                    }.padding(.all , 16)
                
                // MARK: - List Version Of App Cell
                    VStack  {
                        NavigationView {
                            List  {
                                ForEach (appDetailVM.appDetailData  ) { dataListApp in
                                    AppDetailCell( listAppVersion: dataListApp )
                                }
                            }
                            .listStyle(.inset)
                            .scrollContentBackground(.hidden)
                            .background(.white)
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            self.appDetailVM.appDetailInit()
        }
    }
}

#Preview {
    AppDetailVC()
}

//
//  HomeDetailVC.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI
import FittedSheetsSwiftUI
import SDWebImageSwiftUI

struct HomeDetailVC: View {
    
    // MARK: - Properties
    @State          var homePublicApp       : ListAppVersion.Response? = nil
    @Environment(\.dismiss) private var dismiss
    
//    @State var appVersion
    // MARK: - Body
    var body: some View {
        VStack (alignment: .leading ) {
            HStack (spacing : 20 ) {
                Text(homePublicApp?.data.appOfCompany?.stringValue ?? "" )
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
                        // Profile User
                        WebImage(url: URL(string: homePublicApp?.data.icon?.stringValue ?? "" )) { image  in
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
                 
                        Text(homePublicApp?.data.appName?.stringValue  ?? "" )
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
                        List  {
                            ForEach ( homePublicApp?.data.versionList ?? [] , id : \.versionNumber?.intValue ) { data in
                                AppVersionDetailViewCell( homeVersionApp: data )
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
}

#Preview {
    HomeDetailVC()
}

//
//  LaunchScreen.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 4/30/24.
//

import SwiftUI

struct LaunchScreen: View {
//    init() {
//         UITableView.appearance().backgroundColor = .gray // Uses UIColor
//     }
    var body: some View {
        NavigationView {
            List {
                VStack {
                    
                    VStack  (alignment : .leading , spacing: 20 ) {
                        Image("KOSIGN-LOGO")
                            .resizable()
                            .frame(width: 80 , height: 80 )
                        Text ("Welcome to")
                            .font(.customFont(font: .Rubik, style: .medium, size: .h1 ))
                        Text("KOSIGN STORE")
                            .font(.customFont(font: .Rubik, style: .medium , size: .h0))
                            .foregroundColor(Color("MianColor"))
                        Text("Manage your app , download and app version list controller")
                            .font(.customFont(font: .Rubik, style: .regular , size: .h3))
                        
                        
                    }
                    .padding(.vertical , 30)
                    VStack(alignment: .center) {
                        
                       Image("appLogo")
                            .resizable()
                            .frame(width: 40 , height:  40 )
                        
                    }.padding(.vertical , 122)
                  
                    VStack(alignment: .center) {
                        
                        Text("Copyright © 2017 KOSIGN")
                            .font(.customFont(font: .Rubik, style: .medium , size: .h4))
                            .foregroundColor(Color("MianColor"))
                    }
                  
                }
            }.scrollDisabled(true)
        }
        .background(Color.white).edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LaunchScreen()
}

//
//  LaunchScreen.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 4/30/24.
//

import SwiftUI

struct LaunchScreen: View {
    
    @EnvironmentObject private var appRootManager: AppRootManager
    @StateObject  var homeVM     = HomeViewModel()
    var body: some View {
        List {
            VStack {
                // MARK: - Content view
                VStack  (alignment : .leading , spacing: 20 ) {
                    Image("KOSIGN-LOGO")
                        .resizable()
                        .frame(width: 80 , height: 80 )
                    Text ("Welcome to")
                        .font(.customFont(font: .Rubik, style: .medium, size: .h1 ))
                    Text("KOSIGN STORE")
                        .font(.customFont(font: .Rubik, style: .medium , size: .h0))
                        .foregroundColor(Color("MianColor"))
//                    Text("Manage your app , download and app version list controller")
//                        .font(.customFont(font: .Rubik, style: .regular , size: .h3))
                    
                }
//                .padding(.vertical , 30)
                // MARK: - Loading View
                VStack (alignment : .center ) {
                    
                    VStack {

                        ActivityIndicatorLoading()
                        
                    } .frame(height: 380)

                    VStack {
                        Text("Copyright © 2017 KOSIGN")
                            .font(.customFont(font: .Rubik, style: .medium , size: .h4))
                            .foregroundColor(Color("MianColor"))
                    }
                    .padding()
                }     
           
            }
            .frame(width: 350)
        }
        
        .scrollContentBackground(.hidden)
        .listStyle(.insetGrouped)
        .scrollDisabled(true)
        
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                appRootManager.currentRoot = .home
            }
            self.homeVM.checkUserDefault()
        }
        
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
            .environmentObject(AppRootManager())
    }
}

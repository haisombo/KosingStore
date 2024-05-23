//
//  KOSIGNSTORE__iOSApp.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 4/30/24.
//

import SwiftUI
import Foundation
import Firebase
import GoogleSignIn

@main
struct KOSIGNSTORE_iOSApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    @AppStorage("signIn") var isSignIn = false
    @StateObject private var appRootManager = AppRootManager()

    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentRoot {
                case .splash:
                    LaunchScreen()
                case .home:
                    HomeVC()
                }
            }
            .environmentObject(appRootManager)
        }
    }
}


final class AppRootManager: ObservableObject {
    
    @Published var currentRoot: eAppRoots = .splash
    
    enum eAppRoots {
        case splash
        case home
    }
}

//
//  AppDelegate.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/7/24.
//

import Foundation
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if let lang = MyDefaults.get(key: .appLang) as? String {
            Share.language = LanguageCode(rawValue: lang) ?? LanguageCode.Korean
        }
        
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        let sceneConfig : UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
        
    }
    
    //YOU CAN ADD OTHER UIApplicationDelegate here
    
}

//
//  KOSIGNSTORE__iOSApp.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 4/30/24.
//

import SwiftUI

@main
struct KOSIGNSTORE_iOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appdelegate

    var body: some Scene {
        WindowGroup {
//            NavigationStack {
                HomeVC()
//            }
        }
    }
}

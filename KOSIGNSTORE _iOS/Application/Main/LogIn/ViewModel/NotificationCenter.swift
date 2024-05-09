//
//  NotificationCenter.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/8/24.
//

import Foundation

protocol NotificationName {
    var name: Notification.Name { get }
}

extension RawRepresentable where RawValue == String, Self: NotificationName {
    var name: Notification.Name {
        get {
            return Notification.Name(self.rawValue)
        }
    }
}

enum Notifications: String, NotificationName {
    case Logout
    case HomeLogin
    case MoreLogin
    case ChangeLanguage
}

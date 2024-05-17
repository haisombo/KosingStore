//
//  Share.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/10/24.
//

import Foundation

struct Share {
    
    static var language                 : LanguageCode = .English {
        didSet{
            JsonLocalizedManager.language = Share.language
        }
    }
    
    static var jsonLocalized            = JsonLocalizedManager.shared.getJsonLocalized()
    
}

//
//  JsonLocalizedManager.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/10/24.
//

import Foundation

enum LanguageCode: String {
    case Korean     = "ko"
    case English    = "en"
    case Khmer      = "km"
}

class JsonLocalizedManager {
    
    private static var sharedInstance = JsonLocalizedManager()
    
    private static var jsonKey        : JsonLocalized!
    
    static var language               : LanguageCode = .English
    
    static var shared: JsonLocalizedManager = {
        if jsonKey == nil {
            if let path = Bundle.main.path(forResource: "LocalizedString", ofType: "json") {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                    if let json = try? JSONDecoder().decode(JsonLocalized.self, from: data) {
                        jsonKey = json
                    }
                }
            }
        }
        
        return sharedInstance
    }()
    
    func getJsonLocalized() -> JsonLocalized {
        return JsonLocalizedManager.jsonKey
    }
}

extension Encodable {
    
    /// Translate with available language
    ///
    /// - returns: Value by  language.
    var translate: String {
        guard let data = try? JSONEncoder().encode(self) else { return "Json is wrong format!" }
        let dictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
        let value = dictionary?[JsonLocalizedManager.language.rawValue] as? String ?? "Please set language!"
        return value
    }
    
}



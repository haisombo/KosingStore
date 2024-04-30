//
//  Data.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 4/30/24.
//

import Foundation

public extension Data {
    
    // - For Print Response Data
    var prettyPrinted: String {
        return MyJson.prettyPrint(value: self.dataToDic)
    }
    var dataToDic: NSDictionary {
        guard let dic: NSDictionary = (try? JSONSerialization.jsonObject(with: self, options: [])) as? NSDictionary else {
            return [:]
        }
        
        return dic
    }
}

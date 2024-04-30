//
//  Model.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 4/30/24.
//

import Foundation


public struct Upload: Codable {
    struct Response: Decodable {
        var message: String
        var status: Bool
        var data: Data
        
        struct Data: Decodable {
            var file_name: String
        }
    }
}

public struct Download: Codable {
    struct Response {
        
    }
}

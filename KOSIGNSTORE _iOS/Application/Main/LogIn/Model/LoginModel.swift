//
//  LoginModel.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import Foundation

struct Login: Codable {
    struct Request: Encodable {
        var username: AnyCodableValue?
        var password: AnyCodableValue?
//        var token   : AnyCodableValue?
    }
    
    struct Response: Decodable {
        var status: AnyCodableValue
        var message: AnyCodableValue
        var data: Data?
        
        struct Data: Decodable {
            var id: AnyCodableValue?
            var username: AnyCodableValue?
            var email: AnyCodableValue?
            var profile: AnyCodableValue?
            var token: AnyCodableValue?
            var fullName: AnyCodableValue?
            var userRole: AnyCodableValue?
            var createdDate: AnyCodableValue?
            var modifiedDate: AnyCodableValue?
            var listCompany: [ListCompany]?
            
            enum CodingKeys: String, CodingKey {
                case id
                case username
                case email
                case profile
                case token
                case fullName = "full_name"
                case userRole = "user_role"
                case createdDate = "created_date"
                case modifiedDate = "modified_date"
                case listCompany = "list_company"
            }
            
            struct ListCompany: Decodable  {
                var id: AnyCodableValue?
                var name: AnyCodableValue?
                var userRole:  AnyCodableValue?
                
                enum CodingKeys: String, CodingKey {
                    case id = "company_id"
                    case name = "company_name"
                    case userRole = "user_role"
                }
            }
        }
    }
}


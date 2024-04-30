//
//  Content.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 4/30/24.
//

import Foundation

typealias Completion                = ()                -> Void

public enum HTTPMethod : String {
    case GET    = "GET"
    case POST   = "POST"
    case PUT    = "PUT"
    case PATCH  = "PATCH"
    case DELETE = "DELETE"
}

public enum ContentType {
    case Json
    case FormData
}

public enum UploadResponse {
    case progress(percentage: Double)
    case response(data: Data?)
}

public enum XAppVersion : String {
    case base = "20210705"
    
}

public enum NetworkError: Error {
    case invalidURL
    case responseError
    case decoding
    case unknown
    case invalidServerResponse
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .decoding:
            return NSLocalizedString("Error Decoding", comment: "Invalid mapping data")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        case .invalidServerResponse:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}

public enum UserDefaultKey : String {
    case appLang            = "appLang"
}
public enum NotifyKey : String {
    case reloadLocalize                     = "reloadLocalize"
    
}

public enum APIKey: String {

    public static var baseURL  : String = "https://kosignstore.wecambodia.com:8080/kosignstore_v4"

    case mgURL                  = "https://mg.kosign.dev/api/v2/app/setting/866fb6ff-877a-4cdc-bfb5-7619e194cbd4?os=iOS"
    
    case listPublicApp                          =   "/list-public-app"
    case listPrivateApp                         =   "/list-private-app"
    case listPublicAppVersion                   =   "/list-public-app-version"
    case listPrivateAppVersion                  =   "/list-private-app-version"
    case login                                  =   "/login"
    case sendEmail                              =   "/send-email"
    case forgotPassword                         =   "/forget-password"
    case changePassword                         =   "/change-password"
    case deleteAccount                          =   "/delete-user"
    case updateProfile                          =   "/update-profile"
    case GetAllUser                             =   "/v1/users?limit=70"
    case GetAllCategory                         =   "https://api.escuelajs.co/api/v1/categories?limit=10"
    case GetAllProduct                          =   "https://api.escuelajs.co/api/v1/products?limit=10&offset=10"
}

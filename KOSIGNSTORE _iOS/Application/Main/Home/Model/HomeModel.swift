//
//  HomeModel.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import Foundation

enum FilterSection: String, CaseIterable {
    case selectCompany
    case sortList
    case listStyle
}

enum FilterRowtype {
    case titleHeader
    case selectInput
}

enum ListAppType: String, CaseIterable {
    case Public
    case Private
}

enum SizeOfModalAppDetail {
    case fix
    case fullScreen
}

enum UserType: String, CaseIterable {
    case Login
    case Logout
}

enum HomeSection {
    case Header
    case Body
    case Footer
}

enum AppDetailType {
    case Quick
    case Full
}

struct FilterInfoData<T> {
    var title   : FilterSection?
    var value   : T?
}

struct HomeContentBody {
    var id              : Int
    var companyName     : String?
    var appName         : String?
    var appImage        : String?
    var appVersion      : AppDetailBody?
}

struct AppDetailBody {
    var id                  : Int?
    var companyName         : String?
    var appName             : String?
    var appIcon             : String?
    var appCreatedDate      : String?
    var appModifiedDate     : String?
    var isPublic            : Bool?
    var versionList         : [VersionListInfo]
    
    struct VersionListInfo {
        var versionNumber       : String?
        var description         : String?
        var dev                 : AppEnvironment?
        var real                : AppEnvironment?
        
        struct AppEnvironment {
            var modifiedDate        : String?
            var filePath            : String?
            var status              : Int?
        }
    }
}

struct FilterContentBody {
    
    var inputType: InputType?
    var object : [Object]?
    
    enum InputType {
        case checkBox
        case ratio
    }
    
    enum RowType: String {
        case SORT_DATE
        case SORT_APP_NAME
        case LIST_APP_DETAIL
        case LIST_APP_LESS
    }
    
    struct Object {
        var title: String?
        var sectionType : FilterRowtype?
        var selectInput : SelectInput?
        var rowType     : RowType?
        
        struct SelectInput {
            var title : String?
            var isSelected : Bool?
        }
        
        init(title: String, sectionType: FilterRowtype) {
            self.title          = title
            self.sectionType    = sectionType
        }
        
        init(selectInput: SelectInput, sectionType: FilterRowtype) {
            self.selectInput = selectInput
            self.sectionType = sectionType
        }
        
        init(selectInput: SelectInput, sectionType: FilterRowtype, rowType: RowType) {
            self.selectInput = selectInput
            self.sectionType = sectionType
            self.rowType     = rowType
        }
    }
}

struct ListApp: Codable {
    struct Request: Encodable {
        var os_type: AnyCodableValue?
        var user_id: AnyCodableValue?
        var company_id: AnyCodableValue?
        
        init(os_type: AnyCodableValue) {
            self.os_type = os_type
        }
    
        init(os_type: AnyCodableValue, user_id: AnyCodableValue, company_id: AnyCodableValue) {
            self.os_type = os_type
            self.user_id = user_id
            self.company_id = company_id
        }
    }
    struct Response: Decodable {
        var status: AnyCodableValue
        var message: AnyCodableValue
        var data: [AppInfo]
    }
    struct AppInfo: Codable {
        var id                  :   AnyCodableValue
        var name                :   AnyCodableValue?
        var icon                :   AnyCodableValue?
        var appOfCompany        :   AnyCodableValue?
        var appCreatedDate      :   AnyCodableValue?
        var appModifiedDate     :   AnyCodableValue?
        var isPublic            :   AnyCodableValue?
        var dev                 :   AppVersionInfo?
        var real                :   AppVersionInfo?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case icon
            case appOfCompany           = "app_of_company"
            case appCreatedDate         = "app_created_date"
            case appModifiedDate        = "app_modified_date"
            case isPublic               = "is_public"
            case dev                    = "ios_dev"
            case real                   = "ios_real"
        }
        
        struct AppVersionInfo: Codable {
            var versionNumber       :       AnyCodableValue?
            var description         :       AnyCodableValue?
            var appExtension        :       AnyCodableValue?
            var versionID           :       AnyCodableValue?
            var createdDate         :       AnyCodableValue?
            var modifiedDate        :       AnyCodableValue?
            var fileSize            :       AnyCodableValue?
            var filePath            :       AnyCodableValue?
            
            enum CodingKeys: String, CodingKey {
                case versionNumber          = "version_number"
                case description
                case appExtension           = "extension"
                case versionID              = "version_id"
                case createdDate            = "created_date"
                case modifiedDate           = "modified_date"
                case fileSize               = "file_size"
                case filePath               = "file_path"
            }
        }
    }
}

struct ListAppVersion: Codable {
    
    struct Request: Encodable {
        var app_id: AnyCodableValue
        var os_type: AnyCodableValue
    }
    
    struct Response: Decodable {
        var status: AnyCodableValue
        var message: AnyCodableValue
        var data: AppVersionInfo
    }
    
    struct AppVersionInfo: Decodable {
        var id : AnyCodableValue?
        var icon : AnyCodableValue?
        var appName : AnyCodableValue?
        var appOfCompany : AnyCodableValue?
        var appCreatedDate : AnyCodableValue?
        var appModifiedDate : AnyCodableValue?
        var userAccess : AnyCodableValue?
        var isPublic : AnyCodableValue?
        var versionList : [VersionListInfo]
        
        enum CodingKeys: String, CodingKey {
            case id
            case icon
            case appName = "app_name"
            case appOfCompany = "app_of_company"
            case appCreatedDate = "app_created_date"
            case appModifiedDate = "app_modified_date"
            case userAccess = "user_access"
            case isPublic = "is_public"
            case versionList = "version_list"
        }
        
        struct VersionListInfo: Decodable {
            var description : AnyCodableValue?
            var real : VersionListEnvironment?
            var dev: VersionListEnvironment?
            var versionNumber: AnyCodableValue?
            var upload_date         : String?
            var user_upload         : String?
            
            enum CodingKeys: String, CodingKey {
                case description
                case real
                case dev
                case versionNumber = "version_number"
            }
            
            struct VersionListEnvironment: Decodable {
                var appExtension: AnyCodableValue?
                var createdDate: AnyCodableValue?
                var modifiedDate: AnyCodableValue?
                var fileSize: AnyCodableValue?
                var filePath: AnyCodableValue?
                var status: AnyCodableValue?
                
                enum CodingKeys: String, CodingKey {
                    case appExtension = "extension"
                    case createdDate = "created_date"
                    case modifiedDate = "modified_date"
                    case fileSize = "file_size"
                    case filePath = "file_path"
                    case status
                }
            }
        }
    }
}






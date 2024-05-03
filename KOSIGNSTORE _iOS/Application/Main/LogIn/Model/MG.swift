//
//  MG.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/3/24.
//

import Foundation

struct MG {
    
    struct Request: Codable {
        
    }
    
    struct Response: Codable {
    
        let c_act_msg                   : c_act_msg?
        let c_act_ser_msg               : String?
        let c_act_update                : String?
        let c_act_update_msg            : c_act_update_msg
        let c_act_yn                    : String?
        let c_appstore_url              : String?
        let c_available_service         : String?
        let c_available_service_msg     : c_available_service_msg?
        let c_master_id                 : String?
        let c_program_ver               : String?
        let c_start_url                 : String?
    
        struct c_act_msg : Codable {
            let en : String?
            let kh : String?
            let kr : String?
        }
        
        struct c_act_update_msg : Codable {
            let en : String?
            let kh : String?
            let kr : String?
        }
        
        struct c_available_service_msg : Codable {
            let en : String?
            let kh : String?
            let kr : String?
        }
        
        
    }
}


struct MGiOS {
    
    struct Request: Codable {

    }

    struct Response: Codable {

        let c_act_force_update_msg      : c_act_force_update_msg?
        let c_act_msg                   : c_act_msg?
        let c_act_msg_yn                : Bool?
        let c_appstore_url              : String?
        let c_available_service         : String?
        let c_act_update_yn             : Bool?
        let c_available_service_msg     : c_available_service_msg?
        let c_available_service_msg_yn  : Bool?
        let c_base_url                  : String?
        let c_program_ver               : String?

        struct c_act_force_update_msg: Codable {
            let en : String?
            let kh : String?
            let kr : String?
        }

        struct c_act_msg : Codable {
            let en : String?
            let kh : String?
            let kr : String?
        }

        struct c_available_service_msg : Codable {
            let en : String?
            let kh : String?
            let kr : String?
        }


    }
}

struct MGAOS {
    
    struct Request: Codable {

    }

    struct Response: Codable {

        let c_act_force_update_msg      : c_act_force_update_msg?
        let c_act_msg                   : c_act_msg?
        let c_act_msg_yn                : Bool?
        let c_appstore_url              : String?
        let c_available_service         : String?
        let c_act_update_yn             : Bool?
        let c_available_service_msg     : c_available_service_msg?
        let c_available_service_msg_yn  : Bool?
        let c_base_url                  : String?
        let c_program_ver               : String?

        struct c_act_force_update_msg: Codable {
            let en : String?
            let kh : String?
            let kr : String?
        }

        struct c_act_msg : Codable {
            let en : String?
            let kh : String?
            let kr : String?
        }

        struct c_available_service_msg : Codable {
            let en : String?
            let kh : String?
            let kr : String?
        }


    }
}

//
//  JsonLocalized.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/10/24.
//

import Foundation

struct JsonLocalized: Decodable {
    
    struct Language : Codable {
        let km  : String
        let en  : String
        let ko  : String
    }
    
    let more                            : Language
    let setting                         : Language
    let log_out                         : Language
    let welcome                         : Language
    let my_app                          : Language
    let search_placeholder              : Language
    let filter                          : Language
    let select_company                  : Language
    let style_list                      : Language
    let sort_list                       : Language
    let last_update                     : Language
    let app_name                        : Language
    let detail                          : Language
    let less_detail                     : Language
    let apply_filter                    : Language
    let search_not_found                : Language
    let account                         : Language
    let about_us                        : Language
    let language                        : Language
    let notification                    : Language
    let account_desc                    : Language
    let about_us_desc                   : Language
    let language_desc                   : Language
    let notification_desc               : Language
    let profile                         : Language
    let profile_desc                    : Language
    let update                          : Language
    let about_us_detail                 : Language
    let facebook_desc                   : Language
    let language_detail                 : Language
    let select                          : Language
    let change_password                 : Language
    let change_password_desc            : Language
    let old_password                    : Language
    let new_password                    : Language
    let verify_password                 : Language
    let save                            : Language
    let account_delete                  : Language
    let account_delete_desc             : Language
    let account_delete_waring           : Language
    let account_delete_detail           : Language
    let account_delete_confirm          : Language
    let account_delete_confirm_delete   : Language
    let delete                          : Language
    let get                             : Language
    let real                            : Language
    let develop                         : Language
    let real_server                     : Language
    let dev_server                      : Language
    let new_status                      : Language
    let public_status                   : Language
    let update_status                   : Language
    let full_name                       : Language
    let username                        : Language
    let email                           : Language
    let list_all_app                    : Language
    let version                         : Language
    let latest_version                  : Language
    let description                     : Language
    let status_info                     : Language
    let status_success                  : Language
    let status_warning                  : Language
    let status_error                    : Language
    let logout_msg                      : Language
    let cancel                          : Language
    let no_app_version_msg              : Language
    let wrong_credential_msg            : Language
    let offline_msg                     : Language
    let register_profile                : Language
    let register_profile_desc           : Language
    let take_photo                      : Language
    let choose_gallery                  : Language
    let require_field                   : Language
    let invalid_old_password            : Language
    let invalid_verify_password         : Language
    let invalid_email                   : Language
    let update_user_msg                 : Language
    let update_password_msg             : Language
    let same_password_msg               : Language
}

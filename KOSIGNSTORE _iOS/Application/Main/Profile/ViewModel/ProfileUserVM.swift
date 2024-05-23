//
//  ProfileUserVM.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import Foundation

class ProfileVM: ObservableObject {
    @Published var profileInfo = Shared.userInfo
    
    func userNameMatch() -> Bool {
        profileInfo.username == Shared.userInfo.username
    }
    
    func emailMatch() -> Bool {
        profileInfo.email == Shared.userInfo.email
    }
    
    func fullNameMatch() -> Bool {
        profileInfo.fullName == Shared.userInfo.fullName
    }
    
    var isFieldMatch: Bool{
        if !userNameMatch() || !emailMatch() || !fullNameMatch(){
            return true
        }else{
            return false
        }
    }
}

//
//  Shared.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 4/30/24.
//

import Foundation

public struct Shared {
    
    //MARK:- singleton
    public static var share = Shared()
    
    private init() { }
    
    public var jSessionId                       : String?
    public var token                            : String?
    static var timeZone                         : String?
    static var userInfo                         = UserInfo()
    static var userType                         : UserType = .Logout
    
    // app id kosign store
    public var appId                           : String = "866fb6ff-877a-4cdc-bfb5-7619e194cbd4"
}

//
//  AppDetailModel.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/17/24.
//

import Foundation


enum appDetailType : String, CaseIterable {
    case read
    case download
    
}

struct AppDetail : Identifiable     {
    
    var id          = UUID()
    var title       : String?
    var icon        : String?
    var readData    : String?
    var pathFile    : String?
    var roeType     : appDetailType?
    var returnType  : Bool = false
    
}



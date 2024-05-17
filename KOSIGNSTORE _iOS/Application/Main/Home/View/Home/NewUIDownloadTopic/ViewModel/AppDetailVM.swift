//
//  AppDetailVM.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/17/24.
//

import Foundation

class AppDetailVM : ObservableObject {
    
  @Published var appListData        = [AppDetailData]()
  @Published  var appDetailData  = [AppDetailData.AppDetailBody]()
    
    func appDetailInit (){
        appDetailData = [
            AppDetailData.AppDetailBody (title: "24th TOPIK" , icon: "icon_file-pdf" ,  readData: "31st TOPIK Papers Intermediate.pdf" ,pathFile: "" ),
            AppDetailData.AppDetailBody (title: "25th TOPIK" , icon: "icon_file-pdf" ,  readData: "32nd-TOPIK-Papers-Intermediate.pdf" ,pathFile: "" ),
            AppDetailData.AppDetailBody (title: "26th TOPIK" , icon: "icon_file-pdf" ,  readData: "33rd-TOPIK-Papers-Intermediate.pdf" ,pathFile: "" ),
            AppDetailData.AppDetailBody (title: "27th TOPIK" , icon: "icon_file-pdf" ,  readData: "33rd-TOPIK-Papers-Intermediate.pdf" ,pathFile: "" ),
        ]
    }

    
}

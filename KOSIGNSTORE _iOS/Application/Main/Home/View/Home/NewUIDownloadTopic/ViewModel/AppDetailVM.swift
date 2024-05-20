//
//  AppDetailVM.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/17/24.
//

import Foundation

class AppDetailVM : ObservableObject {
    
    
    @Published  var appDetailData  : [AppDetail] = []
    
    init() {
        self.appDetailInit()
        }

    
    func appDetailInit (){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.appDetailData = [
                
                AppDetail (title: "24th TOPIK" , icon: "icon_file-pdf" ,  readData: "31st TOPIK Papers Intermediate" , pathFile: Bundle.main.path(forResource: "31st TOPIK Papers Intermediate", ofType: "pdf") ?? ""),
                AppDetail (title: "25th TOPIK" , icon: "icon_file-pdf" ,  readData: "32nd-TOPIK-Papers-Intermediate" ,pathFile: Bundle.main.path(forResource: "32st TOPIK Papers Intermediate", ofType: "pdf") ?? ""  ),
                AppDetail (title: "26th TOPIK" , icon: "icon_file-pdf" ,  readData: "33rd-TOPIK-Papers-Intermediate" ,pathFile: Bundle.main.path(forResource: "33st TOPIK Papers Intermediate", ofType: "pdf") ?? ""),
                AppDetail (title: "27th TOPIK" , icon: "icon_file-pdf" ,  readData: "33rd-TOPIK-Papers-Intermediate" ,pathFile: Bundle.main.path(forResource: "33st TOPIK Papers Intermediate", ofType: "pdf") ?? "" ),
                
            ]
            
        }
    }

    
}

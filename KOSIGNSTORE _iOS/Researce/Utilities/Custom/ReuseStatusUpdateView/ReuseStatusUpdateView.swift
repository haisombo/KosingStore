//
//  ReuseStatusUpdateView.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

// MARK: - New View
struct ReuseStatusUpdateViewNew : View {
    @State var isNew : Bool
    
    var body: some View {
        if isNew == true  {
            ZStack {
                RoundedRectangle(cornerRadius:0, style: .continuous)
                    .fill(Color("NewColor"))
                    .frame(width: 50 , height: 12)
                    .cornerRadius(4)
                Text ("New")
                    .font(.customFont(font: .Rubik, style: .bold , size: .h11))
                    .foregroundColor(Color(.white))
            }
        }else {
            
        }
      
    }
}

// MARK: - Update view 
struct ReuseStatusUpdateViewUpdate : View {
    @State var isUpdate : Bool
    var body: some View {
        if isUpdate == true {
            ZStack {
                RoundedRectangle(cornerRadius:0, style: .continuous)
                    .fill(Color("DevelopTextColor"))
                    .frame(width: 50 , height: 12)
                    .cornerRadius(4)
                Text ("UPDATE")
                    .font(.customFont(font: .Rubik, style: .bold , size: .h11))
                    .foregroundColor(Color(.white))
            }
        } else {
            
        }

    }
}
// MARK: - Publice view
struct ReuseStatusUpdateViewPublic : View {
    @State var isPublic : Bool
    var body: some View {
        if isPublic == true {
            ZStack {
                RoundedRectangle(cornerRadius:0, style: .continuous)
                    .fill(Color("PublicColor"))
                    .frame(width: 50 , height: 12)
                    .cornerRadius(4)
                Text ("PUBLIC")
                    .font(.customFont(font: .Rubik, style: .bold , size: .h11))
                    .foregroundColor(Color(.white))
            }
        } else {
            
        }

    }
}


//#Preview {
////    ReuseStatusUpdateViewNew()
////    ReuseStatusUpdateViewUpdate()
//    ReuseStatusUpdateViewPublic()
//}

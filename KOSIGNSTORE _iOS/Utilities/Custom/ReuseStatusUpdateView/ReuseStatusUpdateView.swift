//
//  ReuseStatusUpdateView.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct ReuseStatusUpdateViewNew : View {
    @State var isNew : Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius:0, style: .continuous)
                .fill(Color("NewColor"))
                .frame(width: 50 , height: 12)
            Text ("New")
                .font(.customFont(font: .Rubik, style: .bold , size: .h11))
                .foregroundColor(Color(.white))
        }
    }
}
struct ReuseStatusUpdateViewUpdate : View {
    @State var isUpdate : Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius:0, style: .continuous)
                .fill(Color("DevelopTextColor"))
                .frame(width: 50 , height: 12)
            Text ("UPDATE")
                .font(.customFont(font: .Rubik, style: .bold , size: .h11))
                .foregroundColor(Color(.white))
        }
    }
}
struct ReuseStatusUpdateViewPublic : View {
    @State var isPublic : Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius:0, style: .continuous)
                .fill(Color("PublicColor"))
                .frame(width: 50 , height: 12)
            Text ("PUBLIC")
                .font(.customFont(font: .Rubik, style: .bold , size: .h11))
                .foregroundColor(Color(.white))
        }
    }
}


//#Preview {
////    ReuseStatusUpdateViewNew()
////    ReuseStatusUpdateViewUpdate()
//    ReuseStatusUpdateViewPublic()
//}

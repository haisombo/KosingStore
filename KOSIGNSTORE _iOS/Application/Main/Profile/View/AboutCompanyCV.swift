//
//  AboutCompanyCV.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/3/24.
//

import SwiftUI

struct AboutCompanyCV: View {
    var body: some View {
        ZStack  (alignment : .top ){
            RoundedRectangle(cornerRadius: 0, style: .continuous)
                .fill(Color("MianColor"))
                .frame(width: .infinity , height: 120 )
            
            VStack (alignment : .center  , spacing : 16 ) {
                Text ("Account")
                    .foregroundColor(.white)
                    .font(.customFont(font: .Rubik, style: .bold , size: .h2))
                Text("Privacy, Security, Change password ")
                    .foregroundColor(.white)
                    .font(.customFont(font: .Rubik, style: .regular , size: .h6))
            }
        }
        
        List {
            
            ChangePassword()
            
        }
        .listStyle(.insetGrouped)
        
    }
}

struct ChangePassword: View {
    var body: some View {
        HStack {
            VStack {
                HStack  {
                    HStack  (spacing : 20 ){
                        
                        Image("ic_phonelink_lock_24px")
                            .resizable()
                            .frame(width: 20 , height: 20)
                            .padding(.vertical , 10)
                        VStack (alignment : .leading) {
                            Text("Change password")
                                .font(.customFont(font: .Rubik, style: .bold , size: .h3))
                                .foregroundColor(.black)
                            Text("Make sure you remember it")
                                .font(.customFont(font: .Rubik, style: .regular , size: .h7))
                                .foregroundColor(Color("GrayTextColor") )
                        }
                    }
                    
                    Spacer()
                    Image("chevron-right 1")
                        .padding(.horizontal , 10)
                }
            }
        }
    }
}

#Preview {
    AboutCompanyCV()
}

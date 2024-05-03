//
//  AccountCell.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/3/24.
//

import SwiftUI

struct AccountCell: View {
    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 8, style: .continuous)
//                .fill(Color.white)
//                .frame(width: 350 , height: 60 )
//                .shadow(color: Color.gray.opacity(0.1), radius: 8, x: 0.0, y: 8)
//            
            HStack {
                VStack {
                    HStack  {
                        HStack  (spacing : 20 ){
                            
                            Image("account")
                                .resizable()
                                .frame(width: 20 , height: 20)
                            
                            VStack (alignment : .leading) {
                                Text("Account")
                                    .font(.customFont(font: .Rubik, style: .bold , size: .h3))
                                    .foregroundColor(.black)
                                Text("Privacy, security, change number ")
                                    .font(.customFont(font: .Rubik, style: .regular , size: .h7))
                                    .foregroundColor(Color("GrayTextColor") )
                            }
                        }
                        Image("chevron-right 1")
                            .padding(.horizontal , 20)
                    }
                }
            }
            .frame(width: 350 , height: 60)
        }
    }
}

#Preview {
    AccountCell()
}

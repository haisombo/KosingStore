//
//  AccountViewVC.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/3/24.
//

import SwiftUI

struct AccountViewVC: View {
    var body: some View {
        ZStack (alignment : .top ) {
            RoundedRectangle(cornerRadius: 0, style: .continuous)
                .fill(Color("MianColor"))
                .frame(width: .infinity , height: 120 )
            VStack (spacing : 16 ) {
                Text ("About Us")
                    .foregroundColor(.white)
                    .font(.customFont(font: .Rubik, style: .bold , size: .h2))
                Text ("Made by love from KOSIGN, Phnom Penh")
                    .foregroundColor(.white)
                    .font(.customFont(font: .Rubik, style: .regular , size: .h6))
            }
        }
        
        List {
            AccountViewCell()
        }
        .listStyle(.insetGrouped)
    }
}
struct AccountViewCell: View {
    var body: some View {
        HStack {
            VStack {
                HStack  {
                    HStack  (spacing : 20 ){
                        
                        Image("icons8-facebook-100")
                            .resizable()
                            .frame(width: 20 , height: 20)
                            .padding(.vertical , 10)
                        
                        VStack (alignment : .leading) {
                            Text("Feacbook")
                                .font(.customFont(font: .Rubik, style: .bold , size: .h3))
                                .foregroundColor(.black)
                            Text("Like us on Facebook for more")
                                .font(.customFont(font: .Rubik, style: .regular , size: .h7))
                                .foregroundColor(Color("GrayTextColor") )
                        }
                    }
                    Spacer()
                    Image("chevron-right 1")
//                        .padding(.horizontal , 10)
                }
            }
        }
    }
}
#Preview {
    AccountViewVC()
}

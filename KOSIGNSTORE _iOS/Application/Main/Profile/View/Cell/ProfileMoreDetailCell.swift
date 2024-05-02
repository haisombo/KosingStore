//
//  ProfileMoreDetailCell.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct ProfileMoreDetailCell: View {
    @State var isOn: Bool = true

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color.white)
                .frame(width: 350 , height: 108 )
                .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0.0, y: 8)
            HStack {
                VStack {
                    HStack  {
                        HStack  (spacing : 20 ){
                            
                            Image("alarm")
                                .resizable()
                                .frame(width: 20 , height: 20)
                            
                            VStack (alignment : .leading) {
                                Text("Notification")
                                    .font(.customFont(font: .Rubik, style: .bold , size: .h3))
                                    .foregroundColor(.black)
                                Text("Get notified for new app")
                                    .font(.customFont(font: .Rubik, style: .regular , size: .h6))
                                    .foregroundColor(Color("GrayTextColor") )
                            }
                            
                            
                        }
                       
//                        Spacer()
                        Toggle(  isOn: $isOn) {
                            
                        }.tint(Color("MianColor"))
                        
                    }.padding(.horizontal , 35 )
                }
            }
        }
    }
}

#Preview {
    ProfileMoreDetailCell()
}

//
//  ProfileListCell.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct ProfileListCell: View {
    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color("MianColor"))
                .frame(width: 350 , height: 135 )
            VStack (alignment : .leading ) {
                HStack  {
                    Image("defaultIMG")
                        .resizable()
                        .frame(width: 50 , height: 50)
                    VStack (alignment : .leading) {
                        Text("Welcome")
                            .font(.customFont(font: .Rubik, style: .medium , size: .h6))
                            .foregroundColor(.white)
                        Text("Hai Sombo")
                            .font(.customFont(font: .Rubik, style: .bold , size: .h3))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Image("chevron-right")
                }
            }
            .padding(.horizontal ,40)
        }
    }
}

#Preview {
    ProfileListCell()
}

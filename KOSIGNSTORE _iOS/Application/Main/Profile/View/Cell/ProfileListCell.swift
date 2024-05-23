//
//  ProfileListCell.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileListCell: View {
    
    @State var fullName: String?
    
    var body: some View {
        
        //        ZStack {
        //            RoundedRectangle(cornerRadius: 8, style: .continuous)
        //                .fill(Color("MianColor"))
        //                .frame(width: 350 , height: 135 )
        //                .padding()
        VStack (alignment : .leading ) {
            HStack ( alignment : .center , spacing : 30)  {
                WebImage(url: URL(string: Shared.userInfo.image )) { image  in
                    image
                } placeholder: {
                    Image("defaultIMG")
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .modifier(ProfileImageStyle(width: 50, height: 50))
                
                VStack (alignment : .leading) {
                    Text("Welcome")
                        .font(.customFont(font: .Rubik, style: .medium , size: .h6))
                        .foregroundColor(.white)
                    Text(fullName ?? "")
                        .font(.customFont(font: .Rubik, style: .bold , size: .h3))
                        .foregroundColor(.white)
                }
            }
        }
        .frame(width: .infinity , height: .infinity )
    }
}

#Preview {
    ProfileListCell()
}

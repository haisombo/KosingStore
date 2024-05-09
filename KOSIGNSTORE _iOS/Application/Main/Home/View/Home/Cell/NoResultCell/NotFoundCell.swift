//
//  NotFoundCell.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct NotFoundCell: View {
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                VStack ( spacing : 10 ){
                    ZStack  (alignment : .center )   {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color("GrayColor"))
                            .frame(width: 75 , height: 75 )
                        Image (systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 30 , height:  30)
                            .foregroundColor(Color("GrayTextColor"))
                    }
                    
                    Text ("Sorry, no result found.")
                        .font(.customFont(font: .Rubik, style: .regular , size: .h4))
                        .foregroundColor(Color("GrayTextColor"))
                    
                } .frame(height: 120)
            }
        }
    }
}

#Preview {
    NotFoundCell()
}

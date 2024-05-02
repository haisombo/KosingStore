//
//  LessDetailHomeCell.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct LessDetailHomeCell: View {
    var body: some View {
        VStack {
            HStack {
                HStack( spacing: 10.0 ) {
                    Image("defaultIMG")
                        .resizable()
                        .frame(width: 50 , height: 50)
                    Text("Bizplay")
                        .font(.customFont(font: .Rubik, style: .bold , size: .h3))
                }
                
                Spacer()
                HStack {
                    StatusView()
                }
            }
        }
    }
}

#Preview {
    LessDetailHomeCell()
}

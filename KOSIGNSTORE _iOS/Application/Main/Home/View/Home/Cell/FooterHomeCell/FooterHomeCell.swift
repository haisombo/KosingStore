//
//  FooterHomeCell.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct FooterHomeCell: View {
    var body: some View {
        ZStack  {
            VStack (alignment : .center )  {
                Text("Copyright © 2017 KOSIGN All rights reserved")
                    .font(.customFont(font: .Rubik, style: .medium, size: .h8 ))
                    .foregroundColor(Color.black)
            }
            .frame(height: 80 )
        }
    }
}

#Preview {
    FooterHomeCell()
}

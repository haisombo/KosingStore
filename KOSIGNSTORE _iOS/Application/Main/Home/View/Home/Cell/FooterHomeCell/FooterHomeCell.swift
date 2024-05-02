//
//  FooterHomeCell.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct FooterHomeCell: View {
    var body: some View {
        VStack {
            Text("Copyright © 2017 KOSIGN")
                .font(.customFont(font: .Rubik, style: .regular, size: .h9 ))
        }
        .frame( width: .infinity ,height: 150 )
        .background(Color("GrayColor"))
    }
}

#Preview {
    FooterHomeCell()
}

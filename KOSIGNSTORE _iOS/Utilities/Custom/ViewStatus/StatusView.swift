//
//  StatusView.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct StatusView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color("GetColor"))
                .frame(width: 82 , height: 30)
            Text ("GET")
                .font(.customFont(font: .Rubik, style: .bold , size: .h5))
                .foregroundColor(Color("GetTextColor" ))
        }
    }
}

#Preview {
    StatusView()
}

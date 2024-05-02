//
//  ReuseStatusUpdateView.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct ReuseStatusUpdateView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius:0, style: .continuous)
                .fill(Color("NewColor"))
                .frame(width: 50 , height: 12)
            Text ("New")
                .font(.customFont(font: .Rubik, style: .bold , size: .h11))
                .foregroundColor(Color(.white))
        }
    }
}

#Preview {
    ReuseStatusUpdateView()
}

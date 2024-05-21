//
//  ModifiedView.swift
//  KOSIGNStore
//
//  Created by SteveChea  on 20/5/24.
//

import SwiftUI

struct CustomLeadingIcon: ViewModifier{
    func body(content: Content) -> some View {
        content
        .foregroundColor(.gray)
        .padding(.leading, 15)
        .frame(width: 20, height: 20, alignment: .center)
        
    }
}

struct CustomStyleField: ViewModifier{
    @Binding var height : CGFloat
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 10)
            .background(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.clear, lineWidth: 1)
                .frame(width: .infinity, height: height)
                .background(Color.white)
                .cornerRadius(10)
            )
            .shadow(color: Color.gray.opacity(0.2), radius: 5 , x: 0.0, y: 5)
    }
}

struct ProfileImageStyle: ViewModifier{
    @State var width : CGFloat
    @State var height : CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: width ,height: height)
            .clipShape(Circle())
    }
}

struct AppImageStyle: ViewModifier{
    @State var width : CGFloat
    @State var height : CGFloat
    @State var cornerRadius : CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height)
            .cornerRadius(cornerRadius)
    }
}

//
//  LoginPopView.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/16/24.
//

import SwiftUI

// MARK: - Extention PopUp
extension Popup {
    init(isPresented: Binding<Bool>,
         dismissOnTapOutside: Bool = true,
         @ViewBuilder _ content: () -> Content) {
        _isPresented = isPresented
        self.dismissOnTapOutside = dismissOnTapOutside
        self.content = content()
    }
}
 
// MARK: - LogIn From
struct Popup<Content: View>: View {
    
    @Binding var isPresented: Bool
    let content: Content
    let dismissOnTapOutside: Bool
    
    var body: some View {
        
       ZStack {
            Rectangle()
               .fill(.black.opacity(0.6))
                .ignoresSafeArea()
                .onTapGesture {
                    if dismissOnTapOutside {
                        withAnimation {
                            isPresented = false
                        }
                    }
                }
            content
                .frame(
                    width: UIScreen.main.bounds.size.width - 30 , height: 430)
                .background(.white)
                .cornerRadius(12)
                .overlay(alignment: .topTrailing) {
                    Button(action: {
                        withAnimation {
                            isPresented = false
                        }
                    }, label: {
                        Image("cancel")
                    })
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .padding(.all, 12)
                }
        }
    }
}


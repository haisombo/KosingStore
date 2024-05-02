//
//  AppVersionDetailViewCell.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct AppVersionDetailViewCell: View {
    @State private var showData = false

    var body: some View {
        VStack (alignment : .leading ,spacing : 20 )  {
            VStack  (alignment : .leading , spacing: 20 ){
                HStack {
                    
                    Text("Version 1.0.3")
                        .font(.customFont(font: .Rubik, style: .bold , size: .h5))
                    Spacer()
                    Button(action: {
                        showData.toggle()
                    }) {
                        if showData {
                            Image("dropdown")
                        } else {
                            Image("dropup")
                        }
                      
                    }
                }
                
                if showData {
                    VStack (alignment : .leading , spacing: 10.0) {
                        Text("Description")
                            .font(.customFont(font: .Rubik, style: .regular , size: .h5))
                        
                        Text("Lorem Ipsum is simply dummytext of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy ")
                            .font(.customFont(font: .Rubik, style: .regular , size: .h5))
                    }
                }
            }
            
            HStack  {
                HStack (spacing : 20 ) {
                    VStack {
                        Button(action: {
                            
                        }, label: {
                            Text("REAL")
                                .font(.customFont(font: .Rubik, style: .bold , size: .h4))
                                .foregroundColor(Color("GetTextColor") )
                                .frame(height: 34.5)
                                .frame(maxWidth: .infinity)
                                .background(Color ("GetColor"))
                                .cornerRadius(8.0)
                            
                        })
                        .buttonStyle(PressableButtonStyle())
                        
                        Text("4 month ago")
                            .font(.customFont(font: .Rubik, style: .regular , size: .h5))
                            .foregroundColor(Color("GrayTextColor"))
                        
                        
                        
                    }
                    
                    VStack {
                        Button(action: {
                            
                        }, label: {
                            Text("DEVELOP")
                                .font(.customFont(font: .Rubik, style: .bold , size: .h4))
                                .foregroundColor(Color("DevelopTextColor"))
                                .frame(height: 34.5)
                                .frame(maxWidth: .infinity)
                                .background(Color ("DevelopColor"))
                                .cornerRadius(8.0)
                            //                                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
                        })
                        .buttonStyle(PressableButtonStyle())
                        Text("4 month ago")
                            .font(.customFont(font: .Rubik, style: .regular , size: .h5))
                            .foregroundColor(Color("GrayTextColor"))
                    }
                }
                
            }
            
        }
    }
}

struct PressableButtonStyle: ButtonStyle {
    let scaledAmount: CGFloat
    
    init(scaledAmount: CGFloat = 0.9) {
        self.scaledAmount = scaledAmount
    }
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
//            .brightness(configuration.isPressed ? 0.1 : 0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}
#Preview {
    AppVersionDetailViewCell()
}

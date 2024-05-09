//
//  AppVersionDetailViewCell.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct AppVersionDetailViewCell: View {
    // MARK: - Properties
    @State private var showData         = false
    
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
                    VStack (alignment : .leading ) {
                        HStack {
                            Text ("Updateed By :")
                                .font(.customFont(font: .Rubik, style: .regular , size: .h5))
                            Text(" ios_suhito")
                                .font(.customFont(font: .Rubik, style: .bold , size: .h5))
                                .foregroundColor(Color("MianColor"))
                        }
                        
                        HStack {
                            Text ("Modified Date : ")
                                .font(.customFont(font: .Rubik, style: .regular , size: .h6))
                            Text ("2024-05-06 15:12:59")
                                .frame(width: .infinity)
                                .font(.customFont(font: .Rubik, style: .medium , size: .h7))
                                .foregroundColor(.black)
                            Image("historyIcon")
                            Button(action: {
                                //action
                                
                            }, label: {
                                Text("ViewAll")
                                    .font(.customFont(font: .Rubik, style: .regular , size: .h7))
                                    .foregroundColor(.black )
                            })
                        }
                    }
                    VStack (alignment : .leading , spacing: 10.0) {
                        Text("Description")
                            .font(.customFont(font: .Rubik, style: .medium , size: .h5))
                            .foregroundColor(.black)
                        
                        Text("Lorem Ipsum is simply dummytext of the printing and typesetting industry. ")
                            .font(.customFont(font: .Rubik, style: .regular , size: .h5))
                            .foregroundColor(.black)
                    }
                }
            }
            
            HStack  {
                HStack (spacing : 20 ) {
                    VStack {
                        Button(action: {
                            // action
                            print("Real")
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
                            // Action
                            print("Develop")
                        }, label: {
                            Text("DEVELOP")
                                .font(.customFont(font: .Rubik, style: .bold , size: .h4))
                                .foregroundColor(Color("DevelopTextColor"))
                                .frame(height: 34.5)
                                .frame(maxWidth: .infinity)
                                .background(Color ("DevelopColor"))
                                .cornerRadius(8.0)
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

// MARK: - Custom Button Style
struct PressableButtonStyle: ButtonStyle {
    let scaledAmount: CGFloat
    
    init(scaledAmount: CGFloat = 0.9) {
        self.scaledAmount = scaledAmount
    }
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}

#Preview {
    AppVersionDetailViewCell()
}

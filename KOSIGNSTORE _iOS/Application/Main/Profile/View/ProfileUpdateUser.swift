//
//  ProfileUpdateUser.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/3/24.
//

import SwiftUI

struct ProfileUpdateUser: View {
    
    @State private var name                 = ""
    @State private var email                = ""
    @State private var password             = ""
    
    var body: some View {
       VStack {
            VStack {
                // MARK: - Profile User
                ZStack {
                    RoundedRectangle(cornerRadius: 0, style: .continuous)
                        .fill(Color("MianColor"))
                        .frame(width: .infinity , height: 135 )
                    VStack (spacing : 16 ) {
                        Text ("Profile")
                            .foregroundColor(.white)
                            .font(.customFont(font: .Rubik, style: .bold , size: .h2))
                        Text ("Update for you profile information")
                            .foregroundColor(.white)
                            .font(.customFont(font: .Rubik, style: .regular , size: .h6))
                    }
                }
                // MARK: - List View
                List {
                    Section {
                        VStack (alignment : .center ) {
                            ZStack  {
                                Image("defaultIMG")
                                    .resizable()
                                        .frame(width: 100 ,height: 100)
                                Image ("camera_ico")
                            }
                        } .padding(.horizontal , 90)
                    }
                    
                    Section {
                        HStack(alignment: .center) {
                            Image("mail")
                                .padding()
                            TextField("test", text: self.$name)
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.2), radius: 9, x: 0.0, y: 9)
                        .cornerRadius(8)                    }
    
                    Section {
                        HStack(alignment: .center) {
                            Image("user")
                                .padding()
                            TextField("test@gmail.com", text: self.$email)
                                .foregroundColor(.black)
                        }
                        .background(Color(.white))
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.2), radius: 9 , x: 0.0, y: 9)
                        .cornerRadius(8)
                    }
                    Section {
                        HStack(alignment: .center) {
                            Image("user")
                                .padding()
                            TextField("test", text: self.$password)
                        }
                        .background(Color(.white))
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.2), radius: 9 , x: 0.0, y: 9)
                        .cornerRadius(8)
                    }
                    
                } .listStyle(.insetGrouped)

                
                // MARK: - update button
                VStack {
                    Button(action: {
                        // action
                        print("update")
                    }, label: {
                        Text("Update")
                            .font(.customFont(font: .Rubik, style: .bold , size: .h4))
                            .foregroundColor(Color.white)
                            .frame(width: 310, height: 45)
                            .background(Color ("GrayTextColor"))
                            .cornerRadius(15)
                    })
                    .buttonStyle(PressableButtonStyle())
                }
                
            }
       
        }
        
    }
}





#Preview {
    ProfileUpdateUser()
}

//
//  LoginScreen.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct LoginScreen: View {
    // MARK: - Propertiers
    @StateObject var viewModel              = ViewModel()
    @State private var email                = ""
    @State private var password             = ""
    @State private var isFocused: Bool      = false
    @Environment(\.dismiss) private var dismiss
    
    
    
    var body: some View {

                Grid {
                    GridRow {
                        VStack  (spacing : 10){
                            Text("KOSIGN STORE")
                                .font(Font.custom("Rubik-Bold", size: 24.0))
                         
                            Text("Welcome back Please login to continue")
                                .font(Font.custom("RubikRoman-Regular", size: 12.0))
                        }   
                        .padding(.top , 80 )
                        .padding(.vertical , 30 )
             
                    }
                    
                  
                    
                    GridRow {
                        VStack {
                            VStack(alignment: .leading) {
                                VStack {
                                    HStack(alignment: .center) {
                                        Image("mail")
//                                            .resizable()
//                                            .frame(width: 20, height: 20)
                                            .padding()
                                            
                                        TextField("Email", text: self.$email)
                                            
                                    }
                                    .frame(width: 300 , height: 50)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0.0, y: 2)
                                    .padding()
                                    .cornerRadius(8)
                                    
                                    HStack(alignment: .center) {
                                        Image("lock")
//                                            .resizable()
//                                            .frame(width: 20, height: 20)
                                            .padding()
                                        SecureField("Password", text: self.$password)
                                        
                                    }
                              
                                    .frame(width: 300 , height: 50)
                                    .background(Color(.white))
                                    .cornerRadius(10)
                                    .shadow(color: Color.gray.opacity(0.2), radius: 4 , x: 0.0, y: 2)
                                    .padding()
                                    .cornerRadius(8)
                                    
                                }
                            }
                            // MARK: -   Action LogIn
                            Button(action: {
                                self.viewModel.requestLogin(username: email, password: password) {/* [weak self] */result in
                                    switch result {
                                        
                                    case .success(let data):
                                        //action
                                        dismiss().self
                                        
                                        
                                        print("data user \(data)")
                                        
                                        print("""
                                                      🎉🤩
                                                      ===> Fetch Sucess ✅ 👏🥳
                                                      🎉🤩
                                                  """)
                                        
                                    case .failure(let error):
                                        print("""
                                                                  😵❌ Error is ⚠️ \(error.localizedDescription) ⚠️
                                                                  """)
                                    }
                                }
                                
                            }) {
                                Text("LOGIN")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(Color("MianColor"))
                                    .cornerRadius(15.0)
                            }
                            .padding(.vertical , 40)
                            .padding(.bottom , 60)
                        }
                        
                    }
                }
    }
}

#Preview {
    LoginScreen()
}

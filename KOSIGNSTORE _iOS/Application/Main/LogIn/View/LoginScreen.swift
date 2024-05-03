//
//  LoginScreen.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct LoginScreen: View {
    // MARK: - Propertiers
    @StateObject var viewModel      = ViewModel()
    @State private var email                = ""
    @State private var password             = ""
    @State private var isFocused: Bool      = false
    var body: some View {
//        VStack {
//            List  {
                Grid {
                    GridRow {
                        VStack  (spacing : 20){
                            Text("KOSIGN STORE")
                                .font(Font.custom("Rubik-Bold", size: 24.0))
                         
                            Text("Welcome back Please login to continue")
                                .font(Font.custom("RubikRoman-Regular", size: 12.0))
                        }.padding(.vertical , 50 )
                    }      
                  
                    
                    GridRow {
                        VStack() {
                          
                            Spacer()
                            VStack(alignment: .leading, spacing: 0) {
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
                                    .shadow(color: Color.gray.opacity(0.2), radius: 9, x: 0.0, y: 9)
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
                                    .shadow(color: Color.gray.opacity(0.2), radius: 9 , x: 0.0, y: 9)
                                    .padding()
                                    .cornerRadius(8)
                                    
                                    
                                    
                                    Button(action: {
        //
                                    }) {
                                        Text("Forgot Password")
                                            .font(.headline)
                                            .foregroundColor(Color("MianColor"))
                                            .padding()
                                            .frame(width: 300, height: 50)
                                            .cornerRadius(15.0)
                                    }
                                    
                                }
                            }
                            Spacer()
                            // MARK: -   Action LogIn
                            Button(action: {
                                self.viewModel.requestLogin(username: email, password: password) {/* [weak self] */result in
                                    switch result {
                                        
                                    case .success(let data):
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
                        }
                        
                    }
                }
//            }.scrollDisabled(true)
//            
//        }
    }
}

#Preview {
    LoginScreen()
}

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
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    // 1. Create Alert
    let alert = UIAlertController(title: "Erorr",
                                  message: "Your Ticket will Expire Soon.",
                                  preferredStyle: .alert)
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
                                self.viewModel.requestLogin(username: email, password: password) { result in
                                    
                                    switch result {
                                    case .success(let data):
                                        //action
                                        if (data?.status.booleanValue ?? false) {
                                            // Dismiss the view upon successful login
                                            self.presentationMode.wrappedValue.dismiss()
                                            print("login sucess")
                                            
                                        } else {
                                            // show when erorr
                                            self.viewModel.buttonTapped()
                                        }
                                    case .failure(let error):
                                        self.viewModel.buttonTapped()
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                            
                            ) {
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
                            .alert(isPresented: $viewModel.showAlert, content: { () -> Alert in
                                Alert(title: Text("Error").foregroundColor(Color("NewColor") ), message: Text("The email and password entered is invalid. Please try again."), dismissButton: .default (
                                    Text("Okay")
                                        .foregroundColor(Color("NewColor"))
                
                                ))
                            })

                        }
                        
                    }
                }
    }
    
    func customAlert (title : String) {
        alert.addAction(UIAlertAction(title:title ,
                                      style: .default,
                                      handler: { _ in
            print("OK tap")
        }))
        
    }
}

//#Preview {
//    LoginScreen()
//}

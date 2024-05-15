//
//  LoginScreen.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct LoginScreen: View {
 
    // MARK: - Propertiers
    @StateObject        var         viewModel               = ViewModel()
    @State              private var email                   = ""
    @State              private var password                = ""
    @FocusState         private var isFocused               : Bool

    @Binding            var         isPresented             : Bool // Binding variable to control the presentation of the popup
    @State              private var showAlert               = false
    
    // Create Alert
    let alert = UIAlertController(title: "Erorr",
                                  message: "Your Ticket will Expire Soon.",
                                  preferredStyle: .alert)
    // MARK: - Body View
    var body: some View {
        Grid {
            GridRow {
                // header
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
                // Content
                VStack {
                    VStack(alignment: .leading  ) {
                        // email
                        HStack {
                            Image("mail")
                                .padding()
                            TextField("Username and email", text: self.$email)
                        }
                        .keyboardType(.emailAddress)
                        .frame(width: 300 , height: 50)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.2), radius: 4 , x: 0.0, y: 2)
                        // password
                        HStack {
                            Image("lock")
                                .padding()
                            TextField("Password", text: self.$password)
                        }
                        .keyboardType(.numberPad)
                        .frame(width: 300 , height: 50)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.2), radius: 4 , x: 0.0, y: 2)
                        
                    }    .padding()
                    
                    // MARK: -   Action LogIn
                    Button(action: {
                        self.viewModel.requestLogin(username: email, password: password) { result in
                            
                            switch result {
                            case .success(let data):
                                //action
                                if (data?.status.booleanValue ?? false) {
                                    // Dismiss the view upon successful login
                                    self.isPresented = false
//                                    NotificationCenter.default.post(name: Notifications.HomeLogin.name, object: nil)
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
                    
                    // Alert Custom
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
}

//
//#Preview {
// 
//    LoginScreen( )
//}

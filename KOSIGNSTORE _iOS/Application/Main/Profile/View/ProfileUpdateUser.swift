//
//  ProfileUpdateUser.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/3/24.
//

import SwiftUI
import FittedSheetsSwiftUI


struct ProfileUpdateUser: View {
    
    @State private var name                 = ""
    @State private var email                = ""
    @State private var password             = ""
    
    
    @State private var image    : Image? = Image ("") /* = Image("karthick")*/
    
    @State private var shouldPresentImagePicker     = false
    @State private var shouldPresentActionScheet    = false
    @State private var shouldPresentCamera          = false
    
    @State          var showFittedSheet     : Bool = false
    // MARK: - Custom Sheet
    let sheetConfiguration: SheetConfiguration = SheetConfiguration (
        
        sizes: [.marginFromTop(300)  ],
            options: nil,
            sheetViewControllerOptinos: [],
            shouldDismiss: nil,
            didDismiss: nil)
      
    
    var body: some View {
        
       VStack {
            VStack {
                // MARK: - Profile User
                ZStack (alignment: .top ) {
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
                List  {
                    Section {
                        
                        VStack (alignment : .center ) {
                            ZStack  {
                                Button(action: {
                                
                                    self.showFittedSheet.toggle()
                                    
                                  }) {
                                      image!
                                          .resizable()
                                          .aspectRatio(contentMode: .fill)
                                          .frame(width: 100 ,height: 100)
                                          .clipShape(Circle())
//                                    Image("defaultIMG")
//                                      .resizable() // This allows the image to be resized
//                                      .frame(width: 100, height: 100) // This sets the size of the image
                                      
                                      
                                  }
                                  .onTapGesture { self.shouldPresentActionScheet = true }
                                  .sheet(isPresented: $shouldPresentImagePicker) {
                                      SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$shouldPresentImagePicker)
                              }
                                Image ("camera_ico")

                            }
                          
                        }
                        // MARK: - Open Sheet
                        .fittedSheet(isPresented: $showFittedSheet,  configuration: sheetConfiguration )  {

                            RegisterProfile()
                        }
                        
                        .padding(.horizontal , 90)
                        .listRowBackground(Color("BackGoundColor"))
                    }

                    Section {
                        HStack(alignment: .center) {
                            Image("mail")
                                .padding()
                            TextField("test", text: self.$name)
                            
                        }
                        .frame(width: .infinity , height: 40)
//
//                        .background(Color.white)
//                        .cornerRadius(10)
//                        .shadow(color: Color.gray.opacity(0.2), radius: 9, x: 0.0, y: 9)
//                        .cornerRadius(8)
                    }
//                    .frame(width: .infinity , height: 40 )
//                    .background(Color.white)
                    Section {
                        HStack(alignment: .center) {
                            Image("user")
                                .padding()
                            TextField("test@gmail.com", text: self.$email)
                                .foregroundColor(.black)
                        }
                        .frame(width: .infinity , height: 40)
//                        .background(Color(.white))
//                        .cornerRadius(10)
//                        .shadow(color: Color.gray.opacity(0.2), radius: 9 , x: 0.0, y: 9)
//                        .cornerRadius(8)
                    }
//                    .frame(width: .infinity , height: 40 )
//                    .background(Color.white)
                    
                    Section {
                        HStack(alignment: .center) {
                            Image("user")
                                .padding()
                            TextField("test", text: self.$password)
                        }
                        
                        .frame(width: .infinity , height: 40)
//                        .background(Color(.white))
//                        .cornerRadius(10)
//                        .shadow(color: Color.gray.opacity(0.2), radius: 9 , x: 0.0, y: 9)
//                        .cornerRadius(8)
                    }  
                   
//                    .background(Color.white)
                }
                
                 .listStyle(.insetGrouped)
//                .environment(\.defaultMinListRowHeight, 20)
                .scrollContentBackground(.hidden)
                
                .background(Color("BackGoundColor"))
           

                
                // MARK: - update button
                VStack {
                    Button(action: {
                        // action
                        print("update action ")
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
                
            } .background(Color("BackGoundColor"))
       
        }
        
    }
}





#Preview {
    ProfileUpdateUser()
}

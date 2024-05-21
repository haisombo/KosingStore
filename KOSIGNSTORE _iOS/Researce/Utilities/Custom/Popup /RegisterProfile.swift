//
//  RegisterProfile.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/16/24.
//

import SwiftUI

struct RegisterProfile: View {
    var body: some View {
        VStack (alignment : .leading ) {
            VStack (alignment : .leading , spacing: 12) {
                Text("Register Profile")
                    .font(.customFont(font: .Rubik, style: .bold , size: .h2 ))
                    .foregroundColor(Color("MianColor"))
                Text("Take a photo or choose from gallery")
                    .font(.customFont(font: .Rubik, style: .regular , size: .h4 ))
                    .foregroundColor(Color("GrayTextColor"))
                
            }.padding()
                List {
                    Section {
                        HStack (spacing : 20) {
                            Image("camera_ico")
                            Text("Take a Photo")
                                .font(.customFont(font: .Rubik, style: .regular , size: .h4 ))
                                .foregroundColor(Color.black)
//                            self.shouldPresentImagePicker = true
//                            self.shouldPresentCamera = true
                        }
                    }
                    .listRowSeparator(.hidden)
                    
                    Section {
                        HStack  (spacing : 20)  {
//                            self.shouldPresentImagePicker = true
//                            self.shouldPresentCamera = false
                            Image("gallery_ico")
                            Text("Choose from a Gallery")
                                .font(.customFont(font: .Rubik, style: .regular , size: .h4 ))
                                .foregroundColor(Color.black)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .scrollDisabled(true)
                
                .scrollContentBackground(.hidden)
        }
        
    }
//                        .actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
//                            ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
//                               
//                            }), ActionSheet.Button.default(Text("Photo Library"), action: {
//                             
//                            }), ActionSheet.Button.cancel()])
//                        }
                        
}

#Preview {
    RegisterProfile()
}

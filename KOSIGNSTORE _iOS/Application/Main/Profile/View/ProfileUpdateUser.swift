//
//  ProfileUpdateUser.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/3/24.
//

import SwiftUI
import FittedSheetsSwiftUI
import SDWebImageSwiftUI

struct ProfileUpdateUser: View {
    
    @State private var userInfo  = Shared.userInfo
    @State private var image    : Image? = Image ("") /* = Image("karthick")*/
    @State private var shouldPresentImagePicker     = false
    @State private var shouldPresentActionScheet    = false
    @State private var shouldPresentCamera          = false
    @State var showFittedSheet: Bool = false
    
    // MARK: - Custom Sheet
    let sheetConfiguration: SheetConfiguration = SheetConfiguration (
        sizes: [.fixed(250)],
        options: nil,
        sheetViewControllerOptinos: [],
        shouldDismiss: nil,
        didDismiss: nil)
    
    var body: some View {
        
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
                                
                                WebImage(url: URL(string: Shared.userInfo?.image ?? "")) { image  in
                                   image
                                } placeholder: {
                                    Image("defaultIMG")
                                }
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .modifier(ProfileImageStyle(width: 100, height: 100))
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
                .listRowSeparator(.hidden)
                
                Section{
                    EntryField(leftIcon: "user", field: userInfo?.username ?? "", height: 45)
                    EntryField(leftIcon: "mail", field: userInfo?.email ?? "", height: 45)
                    EntryField(leftIcon: "user", field: userInfo?.fullName ?? "", height: 45)
                }
                .listRowSeparator(.hidden)
                .frame(width: .infinity, height: 40)
                .padding(.leading, 0)
                .listRowBackground(Color.clear)
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            
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
        }
        .background(Color("BackGoundColor"))
    }
}

struct EntryField : View {
    var leftIcon: String
    @State var field: String
    @State var height: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(leftIcon)
                    .modifier(CustomLeadingIcon())
                
                ZStack(alignment: .leading){
                    TextField("", text: $field)
                        .autocapitalization(.none)
                        .padding(.leading, 10)
                }
            }
        }
        .modifier(CustomStyleField(height: $height))
    }
}

#Preview {
    ProfileUpdateUser()
}

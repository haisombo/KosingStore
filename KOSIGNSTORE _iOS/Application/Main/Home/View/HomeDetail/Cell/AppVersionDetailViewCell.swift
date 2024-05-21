//
//  AppVersionDetailViewCell.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct AppVersionDetailViewCell: View {
    // MARK: - Properties
    @State          private var showData         = false
    @State          var homeVersionApp           : ListAppVersion.AppVersionInfo.VersionListInfo? = nil
    @State          var dateFormat               = DateFormatter()
    
    var body: some View {
        VStack (alignment : .leading ,spacing : 20 )  {
            VStack  (alignment : .leading , spacing: 20 ){
                HStack {
                    Text("Version : \(homeVersionApp?.versionNumber?.stringValue ?? ""  )")
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
                            Text ("Uploaded By:")
                                .font(.customFont(font: .Rubik, style: .regular , size: .h5))
                            if let userUpload = homeVersionApp?.user_upload {
                                Text(userUpload)
                                    .font(.customFont(font: .Rubik, style: .bold , size: .h5))
                                    .foregroundColor(Color("MianColor"))
                            } else {
                                Text("null" )
                                    .font(.customFont(font: .Rubik, style: .bold , size: .h5))
                                    .foregroundColor(Color("MianColor"))
                            }
                        }
                        HStack {
                            Text ("Modified Date: ")
                                .font(.customFont(font: .Rubik, style: .regular , size: .h6))
                            
                            if let uploadDate = homeVersionApp?.upload_date?.formatDate()  {
                                
                               Text(uploadDate)
                                    .font(.customFont(font: .Rubik, style: .medium , size: .h7))
                                    .foregroundColor(.black)
                            } else {
                                Text ("null")
                                    .font(.customFont(font: .Rubik, style: .medium , size: .h7))
                                    .foregroundColor(.black)
                            }
                            
                            Image("historyIcon")
                            Button(action: {
                                //action
                                print("view history detail. ")
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
                        if let desText = homeVersionApp?.description?.stringValue {
                            Text(desText)
                                .font(.customFont(font: .Rubik, style: .regular , size: .h5))
                                .foregroundColor(.black)
                        } else {
                            Text("null")
                                .font(.customFont(font: .Rubik, style: .regular , size: .h5))
                                .foregroundColor(.black)
                        }
                    }
                } else {
                    
                }
            }
            
            HStack  {
                HStack (spacing : 20 ) {
                    // MARK: - Button Real
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
                        
                        if let date = homeVersionApp?.real?.createdDate?.stringValue {
                            let realDate = dateFormat.getRelativeDate(date: date)
                            Text(realDate)
                                .font(.customFont(font: .Rubik, style: .regular , size: .h5))
                                .foregroundColor(Color("GrayTextColor"))
                        } else {
                            Text("N/A")
                                .font(.customFont(font: .Rubik, style: .regular , size: .h5))
                                .foregroundColor(Color("GrayTextColor"))
                        }
                         
                    }
                    // MARK: - Button Dev
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
                        
                        if let date = homeVersionApp?.dev?.createdDate?.stringValue {
                            let realDate = dateFormat.getRelativeDate(date: date)
                            Text(realDate)
                                .font(.customFont(font: .Rubik, style: .regular , size: .h5))
                                .foregroundColor(Color("GrayTextColor"))
                        } else {
                            Text("N/A")
                                .font(.customFont(font: .Rubik, style: .regular , size: .h5))
                                .foregroundColor(Color("GrayTextColor"))
                        }
                        
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

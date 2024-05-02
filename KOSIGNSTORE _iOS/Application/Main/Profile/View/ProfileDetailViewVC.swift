//
//  ProfileDetailViewVC.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct ProfileDetailViewVC: View {
    var body: some View {
        VStack {
            NavigationView {
                NavigationLink(destination :    ProfileDetailViewVC() )  {
                    VStack {
                        List {
                            ProfileListCell()
                            Section("More") {
                                ProfileMoreDetailCell()
                                ProfileMoreDetailCell()
                            }
                            Section("Setting") {
                                ProfileMoreDetailCell()
                            }
                           
                        }
                        
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Logout")
                                .font(.customFont(font: .Rubik, style: .bold , size: .h4))
                                .foregroundColor(Color.white)
                                .frame(width: 310, height: 45)
//                                .frame(maxWidth: .infinity)
                                .background(Color ("MianColor"))
                                .cornerRadius(8.0)
                            
                            //                                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
                        })
                        .buttonStyle(PressableButtonStyle())

                    }
                }
            }/*.navigationTitle("More").toolbarTitleDisplayMode(.inline)*/
        }
    }
}

#Preview {
    ProfileDetailViewVC()
}

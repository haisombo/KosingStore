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
                VStack {
                    
                    List {
                        
                        NavigationLink (destination : HomeVC() )   {
                            ProfileListCell()
                        }
                        
                        Section("More") {
                            NavigationLink (destination : AboutCompanyCV() )   {
                                AccountCell()
                            }
                            
                            NavigationLink (destination : AccountViewVC()  ) {
                                AccountCell()
                            }
                        }
                        Section("Setting") {
                            NavigationLink (destination : HomeVC() )   {
                                AccountCell()
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    VStack {
                        Button(action: {
                            
                        }, label: {
                            Text("Logout")
                                .font(.customFont(font: .Rubik, style: .bold , size: .h4))
                                .foregroundColor(Color.white)
                                .frame(width: 310, height: 45)
                                .background(Color ("MianColor"))
                                .cornerRadius(8.0)
                            
                                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
                        })
                        .buttonStyle(PressableButtonStyle())
                    }
                }

            }
        }
    }
}

#Preview {
    ProfileDetailViewVC()
}

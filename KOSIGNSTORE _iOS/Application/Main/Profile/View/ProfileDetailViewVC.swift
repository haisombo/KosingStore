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
                        Section {
                            NavigationLink (destination : ProfileUpdateUser() )   {
                                ProfileListCell()
                            }
                        }
                        
                        .listRowBackground(Color("MianColor"))
                        .frame(width: .infinity , height: 100 )
                        
                        Section {
                            NavigationLink (destination : AboutCompanyCV() )   {
                                AccountCell()
                                    .toolbarRole(.editor)
                            }
                            
                            NavigationLink (destination : AccountViewVC()  ) {
                                AccountCell()
                                    
                            }
                        } header: {
                             Text( "More")
                                .font(.customFont(font: .Rubik, style: .bold , size: .h4 ))
                                .foregroundColor(Color("MianColor"))
                        }
                                                
                        Section {
                            NavigationLink (destination : AboutCompanyCV() )   {
                                AccountCell()
                            }
//                            .toolbarRole(.editor)
                            .navigationBarColor(backgroundColor: Color("MianColor") , titleColor: .red)
                            NavigationLink (destination : AccountViewVC() )   {
                                AccountCell()
//                                ProfileMoreDetailCell()
                            }
                        } header: {
                         Text ("Setting")
                            .font(.customFont(font: .Rubik, style: .bold , size: .h4 ))
                            .foregroundColor(Color("MianColor"))
                    }
                        
                        
                    }
                    .listStyle(.insetGrouped)
                    .listRowSpacing(14.0)
                    .environment(\.defaultMinListRowHeight, 70)
                    
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
                
                .background(Color("BackGoundColor") )

            }
        }
    }
}

#Preview {
    ProfileDetailViewVC()
}

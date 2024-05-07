//
//  HomeCell.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeCell: View {
    @StateObject var homeVM     = HomeViewModel()
    @State      var listApp         : ListApp.AppInfo? = nil 
    @State var showSheetView    = false
    
    var body: some View {

            VStack (alignment: .leading ){
                Button(action: {
                    self.showSheetView.toggle()
                }, label: {
                })
                
                HStack (spacing : 10 ) {
                    
//                    Text ("@KOSIGN")
//                    Text("@ \(homeVM.listApp?.data.first?.name?.stringValue ?? "" )")
                    Text("@ \(listApp?.appOfCompany?.stringValue ?? "" )")
                        .font(.customFont(font: .Rubik, style: .bold , size: .h5))
                        .foregroundColor(Color("MianColor"))
                    HStack {
                        if let data = listApp?.isPublic {
                            ReuseStatusUpdateViewPublic(isPublic: false)
                        } else {
                            ReuseStatusUpdateViewPublic(isPublic: true)
                        }
                       
                        if let data = listApp?.appCreatedDate {
                            ReuseStatusUpdateViewUpdate(isUpdate: false)
                        } else {
                            ReuseStatusUpdateViewUpdate(isUpdate: true)
                        }
                 
                        if let data  = listApp?.appModifiedDate?.stringValue {
                            ReuseStatusUpdateViewNew(isNew: false )
                            
                        }   else {
                            ReuseStatusUpdateViewNew(isNew: true )
                        }
                    }
                }
                
                HStack {
                    HStack {
                        WebImage(url: URL(string: listApp?.icon?.stringValue ?? "" ))
//
//                        Image("defaultIMG")
                            .resizable()
                            .frame(width: 50 , height: 50)
                            .cornerRadius(8.0)
                        Text(listApp?.name?.stringValue ?? "" )
                            .font(.customFont(font: .Rubik, style: .bold , size: .h3))
                    }
                    .padding(.vertical , 12)

                 Spacer()
                    
                        StatusView()
                }
                
                HStack {
                    HStack {
                        VStack (alignment : .leading , spacing:  3 )  {
                            Text ("Real Server")
                                .font(.customFont(font: .Rubik, style: .medium , size: .h7))
//                            Text ("A yearago")
//                            Text(homeVM.listApp?.data.first?.real?.createdDate?.stringValue ?? "" )
                            Text(listApp?.real?.createdDate?.stringValue ?? "")
                                .font(.customFont(font: .Rubik, style: .regular , size: .h9))
                                .foregroundColor(.gray.opacity(0.8))
                        }
                        Spacer()
                        VStack(alignment : .leading , spacing:  3 )  {
                            Text ("Dev. Server")
                                .font(.customFont(font: .Rubik, style: .medium , size: .h7))
//                            Text(homeVM.listApp?.data.first?.dev?.createdDate?.stringValue ?? "" )
                            Text(listApp?.dev?.createdDate?.stringValue ?? "" )
//                            Text ("4 months ago")
                                .font(.customFont(font: .Rubik, style: .regular , size: .h9))
                                .foregroundColor(.gray.opacity(0.8))
                        }
                    }
                  
                }
            }  
        .padding(EdgeInsets(top: -20, leading: 0, bottom: 15, trailing: 0))
        .sheet(isPresented: $showSheetView) {
            HomeDetailVC()
                .presentationDetents([.large])

        }
    }
}

#Preview {
    HomeCell()
}

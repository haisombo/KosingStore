//
//  HomeCell.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct HomeCell: View {
    @StateObject var homeVM = HomeViewModel()
    @State var showSheetView = false
    
    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 8, style: .circular  )
//                .fill(Color.white)
//                .frame(width: 374 , height: 154 )
            
            VStack (alignment: .leading ){
                Button(action: {
                    self.showSheetView.toggle()
                }, label: {
                })
                
                HStack (spacing : 10 ) {
                    
//                    Text ("@KOSIGN")
                    Text(homeVM.listApp?.data.first?.name?.stringValue ?? "" )
                        .font(.customFont(font: .Rubik, style: .bold , size: .h5))
                        .foregroundColor(Color("MianColor"))
                    HStack {
                        
//                        if let data = homeVM.listApp?.data.first.
                        ReuseStatusUpdateViewPublic()
                        ReuseStatusUpdateViewUpdate()
                        ReuseStatusUpdateViewNew()
                    }
                }
                
                HStack {
                    HStack {
                        Image("defaultIMG")
                            .resizable()
                            .frame(width: 50 , height: 50)
                       
                        Text("OpenBoard")
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
                            
                            Text ("A yearago")
                                .font(.customFont(font: .Rubik, style: .regular , size: .h9))
                                .foregroundColor(.gray.opacity(0.8))
                        }
                        Spacer()
                        VStack(alignment : .leading , spacing:  3 )  {
                            Text ("Dev. Server")
                                .font(.customFont(font: .Rubik, style: .medium , size: .h7))
                            
                            Text ("4 months ago")
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

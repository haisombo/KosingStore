//
//  HomeCell.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct HomeCell: View {
    @State var showSheetView = false
    
    var body: some View {
        VStack (alignment: .leading ){
            Button(action: {
                self.showSheetView.toggle()
            }, label: {
            })
            
            HStack (spacing : 10 ) {
                
                Text ("@KOSIGN")
                    .font(.customFont(font: .Rubik, style: .bold , size: .h5))
                    .foregroundColor(Color("MianColor"))
                HStack {
                    ReuseStatusUpdateView()
                    ReuseStatusUpdateView()
                    ReuseStatusUpdateView()
                }
            }
            
            HStack {
                HStack {
                    Image("defaultIMG")
                        .resizable()
                        .frame(width: 50 , height: 50)
                   
                    Text("OpenBoard")
                        .font(.customFont(font: .Rubik, style: .bold , size: .h3))
                }.padding(.vertical , 12)

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
    
        .sheet(isPresented: $showSheetView) {
            HomeDetailVC()
                .presentationDetents([.large])

        }
    }
}

#Preview {
    HomeCell()
}

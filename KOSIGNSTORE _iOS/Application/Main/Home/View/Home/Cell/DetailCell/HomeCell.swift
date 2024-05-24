//
//  HomeCell.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI
import SDWebImageSwiftUI
import FittedSheetsSwiftUI

struct HomeCell: View {
    
    // MARK: - Properties
    @State          var showSheetView       = false
    @State          var showFittedSheet     : Bool = false
    @State          var idApp               : Int  = 0
    @State          var dateFormat          = DateFormatter()
    @State var isLoading: Bool              = false

    // MARK: - Custom Sheet
    let sheetConfiguration: SheetConfiguration = SheetConfiguration (
        
            sizes: [.marginFromTop(70.0)],
            options: nil,
            sheetViewControllerOptinos: [],
            shouldDismiss: nil,
            didDismiss: nil)
      
    // MARK: - Body
    var body: some View {

        VStack (alignment: .leading ) {
            // MARK: - Button Action
            Button(action: {
                self.showFittedSheet.toggle()
            
            }, label: {
            })
            // Content
            HStack (spacing : 10 ) {
                Text("@ KOSIGN")
                    .font(.customFont(font: .Rubik, style: .bold , size: .h5))
                    .foregroundColor(Color("MianColor"))
            }
            
            HStack {
                // MARK: - Image Icon Logo App
                HStack {
                    WebImage(url: URL(string: "https://kosignstore.wecambodia.com/storage/image/3d8b0319-0a7a-4977-b1d0-84460ef4f906.png" )) { image in
                        image
                    } placeholder: {
                        Image("defaultIMG")
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .modifier(AppImageStyle(width: 50, height: 50, cornerRadius: 8))
                    
                    HStack {
                        Text("TOPIK II")
                            .font(.customFont(font: .Rubik, style: .bold , size: .h3))
                    }
                }
            }
        }
        .padding(EdgeInsets(top: -20, leading: 0, bottom: 15, trailing: 0))
        // MARK: - Open Sheet
        .fittedSheet(isPresented: $showFittedSheet,  configuration: sheetConfiguration )  {
          
            if isLoading {
                ActivityIndicatorLoading()
            } else {
                AppDetailVC()
            }
        }
        
    }
}

#Preview {
    HomeCell()
}

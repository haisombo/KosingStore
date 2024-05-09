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
    @StateObject    var homeVM              = HomeViewModel()
    @State          var listApp             : ListApp.AppInfo? = nil
    @State          var showSheetView       = false
    @State          var showFittedSheet     : Bool = false
    
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
                // call sheet
                self.showFittedSheet.toggle()
            }, label: {
            })
            
            // Content 
            HStack (spacing : 10 ) {
                
                Text("@ \(listApp?.appOfCompany?.stringValue ?? "" )")
                    .font(.customFont(font: .Rubik, style: .bold , size: .h5))
                    .foregroundColor(Color("MianColor"))
                
                // Status View
                HStack {
                    
                    ReuseStatusUpdateViewPublic     (isPublic: false)
                    ReuseStatusUpdateViewUpdate     (isUpdate: false)
                    ReuseStatusUpdateViewNew        (isNew: false )
                }
            }
            
            HStack (spacing : 50)  {
                
                // MARK: - Image Icon Logo App
                HStack {
                    
                    WebImage(url: URL(string: listApp?.icon?.stringValue ?? "" )) { image in
                        image   .resizable()
                            .frame(width: 50 , height: 50)
                            .cornerRadius(8.0)
                            .aspectRatio(contentMode: .fit)
                        
                    } placeholder: {
                        Image("defaultIMG")
                            .resizable()
                            .frame(width: 50 , height: 50)
                            .cornerRadius(8.0)
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    
                    Text(listApp?.name?.stringValue ?? "" )
                        .font(.customFont(font: .Rubik, style: .bold , size: .h3));
                }
                // Status View Get
                StatusView()
            }
            // Server App Real & Dev
            HStack {
                HStack {
                    VStack (alignment : .leading , spacing:  3 )  {
                        Text ("Real Server")
                            .font(.customFont(font: .Rubik, style: .medium , size: .h7))
                        Text(listApp?.real?.createdDate?.stringValue ?? "")
                            .font(.customFont(font: .Rubik, style: .regular , size: .h9))
                            .foregroundColor(.gray.opacity(0.8))
                    }
                    
                    Spacer()
                    VStack(alignment : .leading , spacing:  3 )  {
                        Text ("Dev. Server")
                            .font(.customFont(font: .Rubik, style: .medium , size: .h7))
                        Text(listApp?.dev?.createdDate?.stringValue ?? "" )
                            .font(.customFont(font: .Rubik, style: .regular , size: .h9))
                            .foregroundColor(.gray.opacity(0.8))
                    }
                }
            }
        }
        
        .padding(EdgeInsets(top: -20, leading: 0, bottom: 15, trailing: 0))
        // MARK: - Open Sheet
        .fittedSheet(isPresented: $showFittedSheet,  configuration: sheetConfiguration) {
            HomeDetailVC()
        }
        
    }
}

#Preview {
    HomeCell()
}

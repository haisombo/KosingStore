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
    @State          var homePublicApp       : ListAppVersion.Response? = nil
    @State          var showSheetView       = false
    @State          var showFittedSheet     : Bool = false
    @State          var idApp               : Int  = 0
    @State          var viewModel           = ViewModel()
    @State          var dateFormat               = DateFormatter()
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
                self.idApp = listApp?.id.intValue ?? 0
                self.homeVM.fetchListPrivateAppVersion(id: idApp ) { result in
                    switch result {
                    case .success( let data ) :
                        
                        self.homePublicApp = data
                        self.showFittedSheet.toggle()
                        print("data have version selected \(data )")
                    case .failure(let erorr) :
                        self.viewModel.buttonTapped()
                        print(erorr.localizedDescription)
                    }
                }
                
                print("id App \(listApp?.id)")
              
                
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
            
            HStack {
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
                    
                    HStack {
                        Text(listApp?.name?.stringValue ?? "" )
                            .font(.customFont(font: .Rubik, style: .bold , size: .h3))
                    }
                    
                    Spacer()
                    
                    // MARK: - Button Action
                    HStack {
                        ZStack {
                            Button(action: {
                                //action
                //                showFittedSheet.toggle()
                            }, label: {
                                Text("GET")
                                    .font(.customFont(font: .Rubik, style: .bold , size: .h7))
                                    .foregroundColor(Color("GetTextColor") )
                                    .frame(width: 82 , height: 30)
                                    .background(Color ("GetColor"))
                                    .cornerRadius(8.0)
                            })
                        }
                    }

                }
            }
            // Server App Real & Dev
            HStack {
                HStack {
                    VStack (alignment : .leading , spacing:  3 )  {
                        Text ("Real Server")
                            .font(.customFont(font: .Rubik, style: .medium , size: .h7))
                        
                        if let date = listApp?.real?.createdDate?.stringValue {
                            let   realDate = dateFormat.getRelativeDate(date: date)
                            Text(realDate)
                                .font(.customFont(font: .Rubik, style: .regular , size: .h9))
                                .foregroundColor(.gray.opacity(0.8))
                        } else {
                            Text("N/A")
                                .font(.customFont(font: .Rubik, style: .regular , size: .h9))
                                .foregroundColor(.gray.opacity(0.8))
                        }
                    }
                    
                    Spacer()
                    VStack(alignment : .leading , spacing:  3 )  {
                        Text ("Dev. Server")
                            .font(.customFont(font: .Rubik, style: .medium , size: .h7))
                        if let date = listApp?.dev?.createdDate?.stringValue {
                            let   realDate = dateFormat.getRelativeDate(date: date)
                            Text(realDate)
                                .font(.customFont(font: .Rubik, style: .regular , size: .h9))
                                .foregroundColor(.gray.opacity(0.8))
                        } else {
                            Text("N/A")
                                .font(.customFont(font: .Rubik, style: .regular , size: .h9))
                                .foregroundColor(.gray.opacity(0.8))
                        }
              
                    }
                }
            }
        }
        
//        .onDisappear {
//            self.appVersion ()
//        }
        .padding(EdgeInsets(top: -20, leading: 0, bottom: 15, trailing: 0))
        // MARK: - Open Sheet
        .fittedSheet(isPresented: $showFittedSheet,  configuration: sheetConfiguration )  {
            HomeDetailVC(homePublicApp: homePublicApp )
        }
        
    }
    
    func appVersion ( ) {
        self.homeVM.fetchListPrivateAppVersion(id: idApp ) { result in
            switch result {
            case .success( let data ) :
                print("data have version selected \(data )")
            case .failure(let erorr) :
                print(erorr.localizedDescription)
            }
        }
    }
}

#Preview {
    HomeCell()
}

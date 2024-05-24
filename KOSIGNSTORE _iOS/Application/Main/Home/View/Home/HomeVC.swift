//
//  HomeVC.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 4/30/24.
//

import SwiftUI
import SDWebImageSwiftUI
import FittedSheetsSwiftUI

struct HomeVC: View {
    
    // MARK: - property
    @StateObject    var         homeViewModel           = HomeViewModel()
    @StateObject    var         logInVM                 = HomeViewModel()
    @State          var         showSheetView           = false
    @State          var         searchText              = ""
    @State          private var presentPopup            = false
    @State          private var mgVM                    = MgVM()
    @State          var         userType                : UserType?
    @State          private var isShowing               = false
    @State          var         indexPathToSetVisible   : IndexPath?
    @State          var         searchEmpty             = false
    @State          var         logInUser               : Login.Response? = nil
    @State private var navigateToWelcome                = false
    @EnvironmentObject private var appRootManager       : AppRootManager
    @State          var         isGoProfileDetail       = false
    @AppStorage("login") var     islogin                = false
    @AppStorage("logout") var     islogout              = false
    @State  private var isSearchEmpty                   = false
    
    // change color navigationTitle
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "MianColor") ?? .black]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "MianColor") ?? .black]
    }
    
    // MARK: - Body
    var body: some View {
        
        ZStack {
            NavigationView {
                VStack (alignment : .center )  {
                    
                    // MARK: - ListView
                    List  {
                        //content
                        Section (content:  {
                            // map list data from api
                                if islogin {
                                        // type Privite --> logIn
                                        ForEach (homeViewModel.listApp?.data ?? []  ,  id : \.id ) { dataListApp in
                                            // cell
                                            HomePrivateCell(listApp: dataListApp, idApp : dataListApp.id.intValue )
                                        }
                                }else {
                                    // type Public --> logOut
                                    HomeCell()
                                }
                            
                            // header
                        }, header: {
                            // footer
                        }, footer:  {
                            GeometryReader { geometry in
                                VStack(alignment: .center) {
                                    if homeViewModel.searchText.isEmpty /*&& homeViewModel.tempListAppData == nil*/ {
                                        //footer
                                        FooterHomeCell()
                                    } else {
                                        //empty cell
                                        NotFoundCell()
                                    }
                                 
                                }.frame(width: geometry.size.width)
                            }
                        })
                    }
                    
                    .listRowSpacing(15.0)
                    .listStyle(InsetGroupedListStyle())
                }
                
                // MARK: - lifeCyle when open screen
                .onAppear {
                    self.listApp()
//                    self.appHomeList()
                    
                    self.mgVM.requestMG(){
                        result in
                        switch result {
                        case .success(let data) :
                            print(data)
                        case .failure(_) :
                            print("fail")
                        }
                    }
                }
                
                // MARK: - Navigation Bar
                .navigationBarLargeTitleItems(trailing: Button(action: {
                    withAnimation(.easeOut  (duration: 0.3)) {
                        // MARK: - check type profile navigation
                        switch Shared.userType {
                        case .Login :
                            isGoProfileDetail = true
                        case .Logout :
                            presentPopup = true
                        }
                    }
                }) {
                    // Profile User
                    WebImage(url: URL(string: Shared.userInfo.image )) { image  in
                       image
                        
                    } placeholder: {
                        Image("defaultIMG")
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .modifier(AppImageStyle(width: 40, height: 40, cornerRadius: 40))
                }
                    .offset(x: -20, y: 8)
                    .background(Color("BackGoundColor"))
                )
                .navigationBarTitle("My App")
            }
            
            // search bar
            .searchable(text: $homeViewModel.searchText , placement: .navigationBarDrawer(displayMode: .automatic ))
            .onChange(of: homeViewModel.searchText) { _ in
                            homeViewModel.filterApps()
                        }

            NavigationLink(destination: ProfileDetailViewVC(), isActive: $isGoProfileDetail.animation(.smooth)) {
                Text("")
                    .hidden()
            }
            // MARK: - present Pop up Log in from
            if presentPopup {
                Popup(isPresented: $presentPopup) {
                    LoginScreen(isPresented: $presentPopup) // Pass the binding variable to LoginScreen
                }
            }
        }
    }

    // MARK: - Method for fetch data
//    func appHomeList () {
//        self.homeViewModel.getHomeData {
//            self.homeViewModel.listApp  = homeViewModel.listApp
//        }
//    }
    // MARK: - Get Data with ueser type
    func listApp ( ) {
        self.homeViewModel.fetchListApp(userID: 18 , companyID: 1 , type:  .Private ) { result in
            switch result {
            case .success(let data):
                self.homeViewModel.listApp   = data
                print("🎉🤩 ===> Fetch Sucess ✅🤩")
                
            case .failure(let error):
                print("😵❌ Error is ⚠️ \(error.localizedDescription) ⚠️")
            }
        }
    }
    // MARK: - Get Data Home --> Public
//    func getDataHomePublic () {
//        self.homeViewModel.fetchListPublicAppVersion(id: 308 ) { result in
//            switch result {
//            case .success(let data):
//                self.homeViewModel.homePublicApp   = data
//                print("🎉🤩 ===> Fetch Sucess ✅🤩"
//                
//            case .failure(let error):
//                print("😵❌ Error is ⚠️ \(error.localizedDescription) ⚠️")
//            }
//        }
//    }
}

// Preview Ui
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeVC()
        }.environmentObject(AppRootManager())
    }
}


//struct SearchBarCustomView: View {
//    @State var searchText = ""
//
//    var body: some View {
//        HStack  {
//            
//            VStack {
//                
//                TextField(" Search App Name ... ", text: $searchText)
//                    .font(.headline )
//                    .padding()
//                    .frame(width: 275 , height:  39.5 )
//                    .textFieldStyle(.plain)
//                    .background(Color.blue)
//                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
//            }
//            
//            // MARK: - Filter Data Search
//            Button(action: {
//                print("-----> Button pressed")
//                
//            }) {
//                HStack {
//                    Image("filter")
//                        .foregroundColor(.black)
//                    Text("Filter")
//                        .font(Font.custom("Rubik-Bold", size: 16.0))
//                        .foregroundColor(.black)
//                    
//                }
//            }
//        }
//    }
//}

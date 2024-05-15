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
    @StateObject    var         logInVM                 = ViewModel()
    @State          var         showSheetView           = false
    @State          var         searchText              = ""
    @State          private var presentPopup            = false
    @State          private var mgVM                    = MgVM()
    @State          var         userType                : UserType?
    @State          private var isShowing               = false
    @State          var         indexPathToSetVisible   : IndexPath?
        
    //sort list using search text
    

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
                            ForEach (homeViewModel.listApp?.data ?? [] , id : \.id) { dataListApp in
                                // cell
                                HomeCell(listApp: dataListApp, idApp : dataListApp.id.intValue )
                            }
                            // header
                        }, header: {
                            // footer
                        }, footer:  {
                            GeometryReader { geometry in
                                VStack(alignment: .center) {
                                    //cell
                                    FooterHomeCell()
                                }.frame(width: geometry.size.width)
                            }
                        })
                    }
                    //                    .animation(.default )
                    .listRowSpacing(15.0)
                    .listStyle(InsetGroupedListStyle())
                }
                
                // MARK: - lifeCyle when open screen
                .onAppear {
                    
                    
                    
                    
                    self.listApp()
                    self.appHomeList()
                    
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
                        switch(logInVM.userType) {
                        case .Login :
                            print("log out")
                            presentPopup = true
                            print("log in")
                            
                        case .Logout :
                            presentPopup = true
                            // Use NavigationLink to navigate to ProfileDetailViewVC
                            NavigationLink(destination: ProfileDetailViewVC()) {
                                Text("Row")
                            }
                            print( "my profile ")
                        default: return
                            
                        }
                    }
                }) {
                    // Profile User
                    WebImage(url: URL(string: logInVM.userInfo?.image ?? "" /* Shared.share.userInfo?.image ?? ""*/ )) { image  in
                    } placeholder: {
                        Image("defaultIMG")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(40)
                    }
                    .resizable()
                    .frame(width: 40, height: 40)
                    .cornerRadius(40)
                    
                }
                    .offset(x: -20, y: 8)
                    .background(Color("BackGoundColor"))
                )
                
                .navigationBarTitle("My App")
            }
            // search bar
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always )
            )
            .navigationViewStyle(StackNavigationViewStyle())
            
            // MARK: - present Pop up Log in from
            if presentPopup {
                Popup(isPresented: $presentPopup) {
                    LoginScreen(isPresented: $presentPopup) // Pass the binding variable to LoginScreen
                }
            }
            
        }
    }

    // MARK: - Method for fetch data
    func appHomeList () {
        self.homeViewModel.getHomeData {
            self.homeViewModel.listApp  = homeViewModel.listApp
        }
    }
    // MARK: - Get Data with ueser type
    func listApp ( ) {
        self.homeViewModel.fetchListApp(userID: 61 , companyID: 1 , type:  .Private ) { result in
            switch result {
            case .success(let data):
                self.homeViewModel.listApp   = data
                print("""
                             🎉🤩
                              ===> Fetch Sucess ✅ 👏🥳
                              🎉🤩
                          """)
                
            case .failure(let error):
               
                print("""
                         😵❌ Error is ⚠️ \(error.localizedDescription) ⚠️
                      """)
            }
        }
    }
    // MARK: - Get Data Home --> Public
    func getDataHomePublic () {
        self.homeViewModel.fetchListPublicAppVersion(id: 308 ) { result in
            switch result {
            case .success(let data):
                self.homeViewModel.homePublicApp   = data
                print("""
                                🎉🤩
                                 ===> Fetch Sucess ✅ 👏🥳
                                 🎉🤩
                             """)
                
            case .failure(let error):
                print("""
                            😵❌ Error is ⚠️ \(error.localizedDescription) ⚠️
                         """)
            }
        }
    }
    
    
    
    
    struct NavigationConfigurator: UIViewControllerRepresentable {
        var configure: (UINavigationController) -> Void = { _ in }
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
            UIViewController()
        }
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
            if let nc = uiViewController.navigationController {
                self.configure(nc)
            }
        }
        
    }
}

// MARK: - Extention PopUp
extension Popup {
    init(isPresented: Binding<Bool>,
         dismissOnTapOutside: Bool = true,
         @ViewBuilder _ content: () -> Content) {
        _isPresented = isPresented
        self.dismissOnTapOutside = dismissOnTapOutside
        self.content = content()
    }
}
 
// MARK: - LogIn From
struct Popup<Content: View>: View {
    
    @Binding var isPresented: Bool
    let content: Content
    let dismissOnTapOutside: Bool
    
    var body: some View {
        
       ZStack {
            Rectangle()
               .fill(.black.opacity(0.6))
                .ignoresSafeArea()
                .onTapGesture {
                    if dismissOnTapOutside {
                        withAnimation {
                            isPresented = false
                        }
                    }
                }
            content
                .frame(
                    width: UIScreen.main.bounds.size.width - 30 , height: 430)
                .background(.white)
                .cornerRadius(12)
                .overlay(alignment: .topTrailing) {
                    Button(action: {
                        withAnimation {
                            isPresented = false
                        }
                    }, label: {
                        Image("cancel")
                    })
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .padding(.all, 12)
                }
        }
    }
}

struct SearchBarCustomView: View {
    @State var searchText = ""

    var body: some View {
        HStack  {
            
            VStack {
                
                TextField(" Search App Name ... ", text: $searchText)
                    .font(.headline )
                    .padding()
                    .frame(width: 275 , height:  39.5 )
                    .textFieldStyle(.plain)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            }
            
            // MARK: - Filter Data Search
            Button(action: {
                print("-----> Button pressed")
                
            }) {
                HStack {
                    Image("filter")
                        .foregroundColor(.black)
                    Text("Filter")
                        .font(Font.custom("Rubik-Bold", size: 16.0))
                        .foregroundColor(.black)
                    
                }
            }
        }
    }
}

// Preview Ui
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeVC()
        }
    }
}

//
//  HomeVC.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 4/30/24.
//

import SwiftUI


struct HomeVC: View {
    
    @State var showSheetView        = false
    @State var searchText           = ""
    @State private var presentPopup = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack (alignment : .center )  {
                    List {
                        Section (content: {
                            HomeCell()
//                            HomeCell()
                            // show when search no data
//                            GeometryReader { geometry in
//                                VStack {
//                                    NotFoundCell()
//                                }.frame(width: geometry.size.width)
//                            }
                        }, header: {
                         
                        }, footer:  {
                            GeometryReader { geometry in
                                VStack(alignment: .center) {
                                    FooterHomeCell()
                                }.frame(width: geometry.size.width)
                            }
                        })
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                .navigationBarLargeTitleItems(trailing:
                                                Button(action: {
                    withAnimation(.linear(duration: 0.3)) {
                        presentPopup = true
                    }
                }) {
                    Image("profile")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .cornerRadius(55)
                }
                    .offset(x: -20, y: 10)
                    .background(Color("BackGoundColor"))
                )
                .navigationBarTitle("My App")
                
 
            }
            
            .searchable(text: $searchText)
            .navigationViewStyle(StackNavigationViewStyle())
            
            // MARK: - present Pop up Log in from
            if presentPopup {
                Popup(isPresented: $presentPopup) {
                    
                    LoginScreen()
                    
                }
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
    
    private let buttonSize: CGFloat = 24
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(.gray.opacity(0.7))
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
                    width: UIScreen.main.bounds.size.width - 30 , height: 500)
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

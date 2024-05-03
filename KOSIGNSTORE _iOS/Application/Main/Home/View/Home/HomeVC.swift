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
                VStack {
                    List {
                        Section  {
                            HomeCell()
                        }
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
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 55, height: 55)
                        .cornerRadius(50)
                }
                    .offset(x: -30, y: 10)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeVC()
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
            
            //                    Spacer()
            
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



//
//  HomeVC.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 4/30/24.
//

import SwiftUI

struct HomeVC: View {
    @State var showSheetView = false
    @State var searchText = ""

    
    var body: some View {
        NavigationView {
            List {
                VStack (alignment : .center ) {
                    Section  {
                        HomeCell()
                    }
                  
                }
            }
//            .listSectionSpacing(45)
            .listStyle(.insetGrouped) // Apply inset grouped list style
        }
     
        .navigationBarTitle("My App")
        .searchable(text: $searchText)
    }
}


#Preview {
    NavigationStack {
        HomeVC()
    }
}

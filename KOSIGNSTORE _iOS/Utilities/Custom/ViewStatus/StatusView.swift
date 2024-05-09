//
//  StatusView.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI
import FittedSheetsSwiftUI

struct StatusView: View {
    
    // MARK: - Properties
    @State var showFittedSheet: Bool = false
        let sheetConfiguration: SheetConfiguration = SheetConfiguration(
            sizes: [.intrinsic],
            options: nil,
            sheetViewControllerOptinos: [],
            shouldDismiss: nil,
            didDismiss: nil)
    
// MARK: - Body
    var body: some View {
        ZStack {
        // MARK: - Button Action
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
        // MARK: - Presented Sheet 
        .fittedSheet(isPresented: $showFittedSheet,
                      configuration: sheetConfiguration) {
            HomeDetailVC()
         }
    }
}

#Preview {
    StatusView()
}

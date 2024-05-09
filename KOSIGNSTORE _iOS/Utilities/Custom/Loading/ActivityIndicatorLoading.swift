//
//  ActivityIndicatorLoading.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 5/2/24.
//

import SwiftUI

struct ActivityIndicatorLoading: View {
    
    @State var isHideLoader         : Bool = true
    
    var body: some View {
        VStack {
            LoaderView(tintColor: .black, scaleSize: 2.0).padding(.bottom,50)/*.hidden(isHideLoader)*/
            
        }
    }
}
struct LoaderView: View {
    var tintColor: Color = .blue
    var scaleSize: CGFloat = 1.0
    
    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}

//
//  Fonts.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 4/30/24.
//

import Foundation
import SwiftUI 

enum CustomFonts: String {
    case Rubik = "Rubik"
}

enum CustomFontStyle: String {
    case bold = "-Bold"
    case black = "-Black"
    case light = "-Light"
    case medium = "-Medium"
    case regular = "-Regular"
    case semiBold = "-SemiBold"
    case thin = "-Thin"
    case variableFontItalic = "-Italic-VariableFont_wght"
    case variableFont = "-VariableFont_wght"
}

enum CustomFontSize: CGFloat {
    
        case h0     = 36.0
        case h1     = 30.0
        case h2     = 27.0
        case h3     = 18.0
        case h4     = 17.0
        case h5     = 16.0
        case h6     = 15.0
        case h7     = 14.0
        case h8     = 13.0
        case h9     = 12.0
        case h10    = 10.0
        case h11    = 8.0
    
}

extension Font {
    
    /// Choose your font to set up
    /// - Parameters:
    ///   - font: Choose one of your font
    ///   - style: Make sure the style is available
    ///   - size: Use prepared sizes for your app
    ///   - isScaled: Check if your app accessibility prepared
    /// - Returns: Font ready to show
    static func customFont(
        font: CustomFonts,
        style: CustomFontStyle,
        size: CustomFontSize,
        isScaled: Bool = true) -> Font {
            
            let fontName: String = font.rawValue + style.rawValue
            
            return Font.custom(fontName, size: size.rawValue)
        }
}

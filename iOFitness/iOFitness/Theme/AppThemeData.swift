//
//  AppThemeData.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit

// Convert RGB into hex
extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    var hexString: String {
        guard let components = cgColor.components, components.count >= 3 else {
            return ""
        }
        
        let red = UInt(components[0] * 255.0)
        let green = UInt(components[1] * 255.0)
        let blue = UInt(components[2] * 255.0)
        
        return String(format: "#%02lX%02lX%02lX", red, green, blue)
    }
}

class AppThemeData {
    // Strings
    static let appName = "iOFitness"
    static let appDescription = "Your Home GYM."
    
    // Colors
    /// Stream
    static let colorPrimary = UIColor(hex: 0x38B6FF)
    static let colorSecondaryBlack = UIColor(hex: 0x101010)
    static let colorSecondaryGray = UIColor(hex: 0x757575)
    static let colorSecondaryWhite = UIColor(hex: 0xFFFFFF)
    static let colorTertiaryBlack = UIColor(hex: 0x000000)
    static let colorTertiaryLightGray = UIColor(hex: 0x979797)
    static let colorTertiaryWhite = UIColor(hex: 0xFAFAFA)
    /// Background
    static let colorBackgroundLight = UIColor(hex: 0xFFFFFF)
    static let colorBackgroundDark = UIColor(hex: 0x101010)
    /// Text
    static let colorTextPrimary = UIColor(hex: 0x38B6FF)
    static let colorTextWhite = UIColor(hex: 0xFFFFFF)
    static let colorTextBlack = UIColor(hex: 0x101010)
    static let colorTextDarkGray = UIColor(hex: 0x333333)
    static let colorTextLightGray = UIColor(hex: 0x757575)
    /// Icon
    static let colorIconSelected = UIColor(hex: 0xFF5722)
    static let colorIconUnselected = UIColor(hex: 0x333333)
    
    // Typography
    /// Stream
    static let fontSizeLargeTitle = UIFont(name: "Raleway-Bold", size: 34)
    static let fontSizeTitle1 = UIFont(name: "Raleway-Bold", size: 27)
    static let fontSizeTitle2 = UIFont(name: "Raleway-Bold", size: 21)
    static let fontSizeTitle3 = UIFont(name: "Raleway-SemiBold", size: 19)
    static let fontSizeHeadline = UIFont(name: "Raleway-SemiBold", size: 17)
    static let fontSizeBody = UIFont(name: "Raleway-Regular", size: 16)
    static let fontSizeCallout = UIFont(name: "Raleway-Regular", size: 15)
    static let fontSizeSubhead = UIFont(name: "Raleway-Regular", size: 14)
    static let fontSizeFootnote = UIFont(name: "Raleway-Regular", size: 12)
    static let fontSizeCaption1 = UIFont(name: "Raleway-SemiBold", size: 12)
    static let fontSizeCaption2 = UIFont(name: "Raleway-Regular", size: 11)
    /// Button
    static let fontSizeButton = UIFont(name: "Raleway-SemiBold", size: 16)
    static let fontSizeTextButton = UIFont(name: "Raleway-SemiBold", size: 16)
    
    // Corner Radius
    /// Button
    static let cornerRadiusButton: CGFloat = 8
    static let cornerRadiusCard: CGFloat = 8
}

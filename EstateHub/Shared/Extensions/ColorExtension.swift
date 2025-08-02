//
//  ColorExtension.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import UIKit

extension UIColor {
    
    ///
    /// UIColor from hex
    ///
    /// - Parameters:
    ///   - hex: UInt32
    ///   - alpha: CGFloat
    ///
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}

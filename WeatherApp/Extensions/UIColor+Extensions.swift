//
//  UIColor+Extensions.swift
//  WeatherApp
//
//  Created by Александр Иванов on 24.02.2026.
//

import UIKit

extension UIColor {
    
    // MARK: HEX Initializer
    
    convenience init(hex: String, opacity: Double? = nil) {
        let cleaned = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        
        guard Scanner(string: cleaned).scanHexInt64(&int) else {
            self.init(white: 0, alpha: 1)
            return
        }
        
        let r, g, b, a: UInt64
        
        switch cleaned.count {
        case 3:
            (r, g, b, a) = (
                (int >> 8) * 17,
                (int >> 4 & 0xF) * 17,
                (int & 0xF) * 17,
                255
            )
            
        case 4:
            (r, g, b, a) = (
                (int >> 12) * 17,
                (int >> 8 & 0xF) * 17,
                (int >> 4 & 0xF) * 17,
                (int & 0xF) * 17
            )
            
        case 6:
            (r, g, b, a) = (
                int >> 16,
                int >> 8 & 0xFF,
                int & 0xFF,
                255
            )
            
        case 8:
            (r, g, b, a) = (
                int >> 24,
                int >> 16 & 0xFF,
                int >> 8 & 0xFF,
                int & 0xFF
            )
            
        default:
            self.init(white: 0, alpha: 1)
            return
        }
        
        let alpha = opacity
            .map { CGFloat(max(0, min(1, $0))) }
            ?? CGFloat(a) / 255
        
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: alpha
        )
    }
}

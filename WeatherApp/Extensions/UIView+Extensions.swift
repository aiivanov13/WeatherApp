//
//  UIView+Extensions.swift
//  WeatherApp
//
//  Created by Александр Иванов on 20.02.2026.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
    
    func applyLiquidGlass(
        glassStyle: UIGlassEffect.Style = .clear,
        cornerRadius: CGFloat = 30
    ) {
        backgroundColor = .clear
        subviews.filter { $0.tag == 999 }.forEach { $0.removeFromSuperview() }
        
        let glassEffect = UIGlassEffect(style: glassStyle)
        let glassView = UIVisualEffectView(effect: glassEffect)
        glassView.tag = 999
        glassView.frame = bounds
        glassView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        glassView.layer.cornerRadius = cornerRadius
        glassView.clipsToBounds = true
        
        addSubview(glassView)
        sendSubviewToBack(glassView)
    }
}

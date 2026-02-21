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
}

//
//  UIStackView+Extensions.swift
//  WeatherApp
//
//  Created by Александр Иванов on 25.02.2026.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}

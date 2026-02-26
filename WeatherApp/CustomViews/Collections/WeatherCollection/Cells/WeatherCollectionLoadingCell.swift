//
//  WeatherCollectionLoadingCell.swift
//  WeatherApp
//
//  Created by Александр Иванов on 25.02.2026.
//

import UIKit
import SnapKit

final class WeatherCollectionLoadingCell: UICollectionViewCell {
    
    // MARK: - UI
    

    // MARK: - Properties


    // MARK: - Initializers
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        contentView.applyLiquidGlass()
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        
    }
    
    private func setupLayout() {
        
    }
    
    // MARK: - Methods

    func setupAnimation() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0.3
        animation.duration = 1
        animation.autoreverses = true
        animation.repeatCount = .infinity
        
        layer.add(animation, forKey: "pulse")
    }
}

//
//  WeatherCollectionHoursCell.swift
//  WeatherApp
//
//  Created by Александр Иванов on 21.02.2026.
//

import UIKit
import SnapKit

final class WeatherCollectionHoursCell: UICollectionViewCell {
        
    struct Data: Hashable, Sendable {
        
    }
    
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
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        
    }
    
    private func setupLayout() {
        
    }
    
    // MARK: - Methods

}

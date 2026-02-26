//
//  WeatherCollectionHeader.swift
//  WeatherApp
//
//  Created by Александр Иванов on 25.02.2026.
//

import UIKit
import SnapKit

final class WeatherCollectionHeader: UICollectionReusableView {
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = Colors.white
        view.font = Fonts.title
        return view
    }()
    
    var text: String = "" {
        didSet {
            titleLabel.text = text
        }
    }
    
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
        addSubview(titleLabel)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.directionalHorizontalEdges.centerY.equalToSuperview()
        }
    }
}

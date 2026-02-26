//
//  WeatherCollectionCurrentCell.swift
//  WeatherApp
//
//  Created by Александр Иванов on 21.02.2026.
//

import UIKit
import SnapKit

final class WeatherCollectionCurrentCell: UICollectionViewCell {
    
    nonisolated struct Data: Sendable, Hashable {
        
        var name: String
        var tempC: Double
    }
    
    // MARK: - UI
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = Colors.white
        view.font = Fonts.headlineLarge
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var tempLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = Colors.white
        view.font = Fonts.headlineThin
        return view
    }()

    // MARK: - Properties
    
    var data: Data? {
        didSet {
            guard let data else { return }
            nameLabel.text = data.name
            tempLabel.text = "\(Int(data.tempC.rounded()))°"
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
        contentView.addSubviews(
            nameLabel,
            tempLabel
        )
    }
    
    private func setupLayout() {
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        
        tempLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(24)
            $0.height.equalTo(62)
        }
    }
    
    // MARK: - Methods

}

//
//  WeatherCollectionHoursCell.swift
//  WeatherApp
//
//  Created by Александр Иванов on 21.02.2026.
//

import UIKit
import SnapKit
import Kingfisher

final class WeatherCollectionHoursCell: UICollectionViewCell {
        
    nonisolated struct Data: Sendable, Hashable {
        let hour: Int?
        let tempC: Double
        let tzID: String
        let icon: String
    }
    
    // MARK: - UI
    
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var hourLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = Colors.lightGray
        view.font = Fonts.subtitle
        return view
    }()
    
    private lazy var tempLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = Colors.white
        view.font = Fonts.headline
        return view
    }()
    
    private lazy var formatter: DateFormatter = {
        let view = DateFormatter()
        view.dateFormat = "HH:mm"
        view.locale = Locale(identifier: "ru_RU")
        return view
    }()

    // MARK: - Properties
    
    var data: Data? {
        didSet {
            guard let data else { return }
            
            let date = Date(timeIntervalSince1970: TimeInterval(data.hour ?? 0))

            if let timeZone = TimeZone(identifier: data.tzID) {
                formatter.timeZone = timeZone
            }

            let timeString = formatter.string(from: date)
            hourLabel.text = timeString
            tempLabel.text = "\(Int(data.tempC.rounded()))°"
            
            if let url = URL(string: "https:" + data.icon) {
                iconView.kf.setImage(with: url)
            }
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
        contentView.applyLiquidGlass()
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        contentView.addSubviews(
            iconView,
            hourLabel,
            tempLabel
        )
    }
    
    private func setupLayout() {
        iconView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.height.width.equalTo(30)
            $0.centerX.equalToSuperview()
        }
        
        hourLabel.snp.makeConstraints {
            $0.top.equalTo(iconView.snp.bottom).offset(2)
            $0.directionalHorizontalEdges.equalToSuperview().inset(8)
            $0.height.equalTo(16)
        }
        
        tempLabel.snp.makeConstraints {
            $0.top.equalTo(hourLabel.snp.bottom)
            $0.bottom.directionalHorizontalEdges.equalToSuperview().inset(8)
            $0.height.equalTo(20)
        }
    }
    
    // MARK: - Methods

    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.kf.cancelDownloadTask()
    }
}

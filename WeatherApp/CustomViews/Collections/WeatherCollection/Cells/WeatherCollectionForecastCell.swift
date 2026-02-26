//
//  WeatherCollectionForecastCell.swift
//  WeatherApp
//
//  Created by Александр Иванов on 21.02.2026.
//

import UIKit
import SnapKit
import Kingfisher

final class WeatherCollectionForecastCell: UICollectionViewCell {
    
    nonisolated struct Data: Sendable, Hashable {
        let date: Int
        let minTempC: Double
        let maxTempC: Double
        let tzID: String
        let icon: String
    }
    
    // MARK: - UI
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.textColor = Colors.lightGray
        view.font = Fonts.subtitle
        return view
    }()
    
    private lazy var dayLabel: UILabel = {
        let view = UILabel()
        view.textColor = Colors.white
        view.font = Fonts.headline
        return view
    }()
    
    private lazy var dayContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var minTempLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = Colors.white
        view.font = Fonts.headline
        return view
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.textColor = Colors.white
        view.font = Fonts.headline
        return view
    }()
    
    private lazy var formatter: DateFormatter = {
        let view = DateFormatter()
        view.locale = Locale(identifier: "ru_RU")
        return view
    }()

    // MARK: - Properties
    
    var data: Data? {
        didSet {
            guard let data else { return }
            
            if let timeZone = TimeZone(identifier: data.tzID) {
                formatter.timeZone = timeZone
            }
            
            let date = Date(timeIntervalSince1970: TimeInterval(data.date))
            formatter.dateFormat = "d MMMM"
            
            let dateString = formatter.string(from: date)
            dateLabel.text = dateString
            
            if TimeInterval(data.date) == startOfDayUTC() {
                dayLabel.text = "Сегодня"
            } else {
                let formatter = DateFormatter()
                formatter.dateFormat = "EE"
                formatter.locale = Locale(identifier: "ru_RU")
                let dayString = formatter.string(from: date)
                dayLabel.text = dayString
            }
            
            minTempLabel.text = "\(Int(data.minTempC.rounded()))°"
            maxTempLabel.text = "\(Int(data.maxTempC.rounded()))°"
            
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
        dayContainer.addArrangedSubviews(
            dateLabel,
            dayLabel
        )
        contentView.addSubviews(
            dayContainer,
            iconView,
            minTempLabel,
            maxTempLabel
        )
    }
    
    private func setupLayout() {
        dayContainer.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.directionalVerticalEdges.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        iconView.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(dayContainer.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(30)
        }
        
        minTempLabel.snp.makeConstraints {
            $0.leading.equalTo(iconView.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(40)
        }
        
        maxTempLabel.snp.makeConstraints {
            $0.leading.equalTo(minTempLabel.snp.trailing)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(40)
        }
    }
    
    // MARK: - Methods
    
    private func startOfDayUTC(for date: Date = Date()) -> TimeInterval {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar.startOfDay(for: date).timeIntervalSince1970
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.kf.cancelDownloadTask()
    }
}

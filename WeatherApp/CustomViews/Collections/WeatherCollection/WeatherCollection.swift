//
//  WeatherCollection.swift
//  WeatherApp
//
//  Created by Александр Иванов on 21.02.2026.
//

import UIKit

final class WeatherCollection: UICollectionView {

    enum Section {
        case current(WeatherCollectionCurrentCell.Data)
        case hours(WeatherCollectionHoursCell.Data)
        case forecast(WeatherCollectionForecastCell.Data)
    }
    
    var sectionData: [Section] = [] {
        didSet {
            reloadData()
        }
    }
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        dataSource = self
        collectionViewLayout = createLayout()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setups
    
    private func setup() {
        register(WeatherCollectionCurrentCell.self)
        register(WeatherCollectionHoursCell.self)
        register(WeatherCollectionForecastCell.self)
    }
}

// MARK: - Data Source

extension WeatherCollection: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sectionData[section] {
        case .current:
            1
        case .hours:
            1
        case .forecast:
            1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sectionData[indexPath.section] {
        case .current:
            let cell: WeatherCollectionCurrentCell = dequeue(WeatherCollectionCurrentCell.self, for: indexPath)
            
            return cell
        case .hours:
            let cell: WeatherCollectionHoursCell = dequeue(WeatherCollectionHoursCell.self, for: indexPath)

            return cell
        case .forecast:
            let cell: WeatherCollectionForecastCell = dequeue(WeatherCollectionForecastCell.self, for: indexPath)

            return cell
        }
    }
}

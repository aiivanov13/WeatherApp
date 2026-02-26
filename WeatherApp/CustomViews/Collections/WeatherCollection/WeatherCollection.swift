//
//  WeatherCollection.swift
//  WeatherApp
//
//  Created by Александр Иванов on 21.02.2026.
//

import UIKit

final class WeatherCollection: UICollectionView {

    typealias WeatherDataSource = UICollectionViewDiffableDataSource<Section, Item>

    enum Section: Int, CaseIterable {
        case current
        case hours
        case forecast
        
        var title: String? {
            switch self {
            case .current, .hours:
                return nil
            case .forecast:
                return "Погода на 3 дня"
            }
        }
    }

    nonisolated enum Item: Sendable, Hashable {
        case loading(UUID)
        case empty(UUID)
        case current(WeatherCollectionCurrentCell.Data)
        case hours(WeatherCollectionHoursCell.Data)
        case forecast(WeatherCollectionForecastCell.Data)
    }
    
    private var weatherDataSource: WeatherDataSource?
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionViewLayout = createLayout()
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        configureDataSource()
        applyInitialSnapshot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setups
    
    private func configureDataSource() {
        let loadingRegistration = CellRegistration<WeatherCollectionLoadingCell, UUID> {
            cell, _, data in
            
            cell.setupAnimation()
        }
        let emptyRegistration = CellRegistration<UICollectionViewCell, UUID> {
            cell, _, data in
        }
        let currentRegistration = CellRegistration<WeatherCollectionCurrentCell, WeatherCollectionCurrentCell.Data> {
            cell, _, data in
            cell.data = data
        }
        
        let hoursRegistration = CellRegistration<WeatherCollectionHoursCell, WeatherCollectionHoursCell.Data> {
            cell, _, data in
            cell.data = data
        }
    
        let forecastRegistration = CellRegistration<WeatherCollectionForecastCell, WeatherCollectionForecastCell.Data> {
            cell, _, data in
            cell.data = data
        }
        
        let headerRegistration = SupplementaryRegistration<WeatherCollectionHeader>(elementKind: UICollectionView.elementKindSectionHeader) {
            [weak self] view, _, indexPath in
            
            let section = self?.weatherDataSource?.snapshot().sectionIdentifiers[indexPath.section]
            
            if let title = section?.title {
                view.text = title
            }
        }
        
        weatherDataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: self) {
            collectionView, indexPath, item in
            switch item {
            case .loading(let item):
                return collectionView.dequeueConfiguredReusableCell(
                    using: loadingRegistration,
                    for: indexPath,
                    item: item
                )
            case .current(let item):
                return collectionView.dequeueConfiguredReusableCell(
                    using: currentRegistration,
                    for: indexPath,
                    item: item
                )
            case .hours(let item):
                return collectionView.dequeueConfiguredReusableCell(
                    using: hoursRegistration,
                    for: indexPath,
                    item: item
                )
            case .forecast(let item):
                return collectionView.dequeueConfiguredReusableCell(
                    using: forecastRegistration,
                    for: indexPath,
                    item: item
                )
            case .empty(let item):
                return collectionView.dequeueConfiguredReusableCell(
                    using: emptyRegistration,
                    for: indexPath,
                    item: item
                )
            }
        }
        
        weatherDataSource?.supplementaryViewProvider = { collectionView, _, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration,
                for: indexPath
            )
        }
    }
    
    private func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.current, .hours, .forecast])
        
        let hoursLoading = Array(0..<24).map { _ in Item.loading(UUID()) }
        
        snapshot.appendItems([.empty(UUID())], toSection: .current)
        snapshot.appendItems(hoursLoading, toSection: .hours)
        snapshot.appendItems([.loading(UUID()), .loading(UUID()), .loading(UUID())], toSection: .forecast)
        
        weatherDataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func replaceData(with items: [Item]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.current, .hours, .forecast])
        
        items.forEach {
            switch $0 {
            case .current:
                snapshot.appendItems([$0], toSection: .current)
            case .hours:
                snapshot.appendItems([$0], toSection: .hours)
            case .forecast:
                snapshot.appendItems([$0], toSection: .forecast)
            case .loading, .empty:
                snapshot.appendItems([.empty(UUID())], toSection: .current)
                snapshot.appendItems([.loading(UUID()), .loading(UUID())], toSection: .hours)
                snapshot.appendItems([.loading(UUID()), .loading(UUID()), .loading(UUID())], toSection: .forecast)
            }
        }
        
        weatherDataSource?.apply(snapshot, animatingDifferences: false)
    }
}

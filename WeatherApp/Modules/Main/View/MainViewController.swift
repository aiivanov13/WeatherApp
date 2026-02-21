//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Александр Иванов on 20.02.2026.
//

import UIKit
import SnapKit
import Observation

@MainActor
final class MainViewController: UIViewController {
    
    // MARK: - Arcitecture
    
    // Dependencies
    private let viewModel: MainViewModel
    private let localization: MainLocalization
    
    // Initializers
    init(viewModel: MainViewModel, localization: MainLocalization) {
        self.viewModel = viewModel
        self.localization = localization
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI

    private lazy var weatherCollectionView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
        viewModel.getData()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        view.addSubviews(weatherCollectionView, titleLabel)
    }
    
    private func setupLayout() {
        weatherCollectionView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Binding
    
    private func bind() {
        withObservationTracking { [weak self] in
            self?.render()
        } onChange: { [weak self] in
            DispatchQueue.main.async {
                self?.bind()
            }
        }
    }
    
    private func render() {
        titleLabel.text = viewModel.name
    }
}

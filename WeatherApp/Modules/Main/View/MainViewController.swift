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
    
    private lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = Images.background
        view.contentMode = .scaleAspectFill
        return view
    }()

    private lazy var weatherCollectionView: WeatherCollection = {
        let view = WeatherCollection()
        view.refreshControl = refresher
        return view
    }()
    
    private lazy var refresher: UIRefreshControl = {
        let view = UIRefreshControl()
        let action = UIAction { [weak self] _ in
            self?.viewModel.loadData()
        }
        view.addAction(action, for: .valueChanged)
        view.tintColor = Colors.white
        return view
    }()
    
    private lazy var errorModal: ErrorModal = {
        let view = ErrorModal()
        view.onRefreshTap = { [weak self] in
            self?.viewModel.loadData()
        }
        view.isHidden = true
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
        viewModel.loadData()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        view.backgroundColor = Colors.white
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        view.addSubviews(
            backgroundImage,
            weatherCollectionView,
            errorModal
        )
    }
    
    private func setupLayout() {
        backgroundImage.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
        
        weatherCollectionView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
        
        errorModal.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
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
        errorModal.isHidden = !viewModel.isError
        
        if !viewModel.isLoading {
            refresher.endRefreshing()
        }
        
        guard !viewModel.items.isEmpty else { return }
        weatherCollectionView.replaceData(with: viewModel.items)
    }
}

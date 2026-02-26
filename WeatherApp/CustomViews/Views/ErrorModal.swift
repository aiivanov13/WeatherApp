//
//  ErrorModal.swift
//  WeatherApp
//
//  Created by Александр Иванов on 25.02.2026.
//

import UIKit
import SnapKit

final class ErrorModal: UIView {
    
    private lazy var contentContainer: UIView = {
        let view = UIView()
        view.applyLiquidGlass()
        return view
    }()
    
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.image = Images.wSymbol
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = Colors.white
        view.font = Fonts.headline
        view.textAlignment = .center
        view.text = "Упс, произошла какая-то ошибка..."
        return view
    }()
    
    private lazy var refreshButton: AccentButton = {
        let view = AccentButton()
        view.title = "Обновить"
        view.onTap = { [weak self] in
            self?.onRefreshTap?()
        }
        return view
    }()
    
    var onRefreshTap: (() -> ())?
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = Colors.transparentBlack
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        contentContainer.addSubviews(
            iconView,
            titleLabel,
            refreshButton
        )
        
        addSubview(contentContainer)
    }
    
    private func setupLayout() {
        contentContainer.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        iconView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconView.snp.bottom).offset(16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        
        refreshButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.directionalHorizontalEdges.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }
}

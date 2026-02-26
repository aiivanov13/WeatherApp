//
//  AccentButton.swift
//  WeatherApp
//
//  Created by Александр Иванов on 25.02.2026.
//

import UIKit

final class AccentButton: UIButton {
    
    var onTap: (() -> ())?
    
    var title: String {
        get { configuration?.title ?? "" }
        set { configuration?.title = newValue }
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let action = UIAction { [weak self] _ in
            self?.onTap?()
        }
        addAction(action, for: .touchUpInside)
        
        var configuration = UIButton.Configuration.prominentGlass()
        configuration.baseForegroundColor = Colors.white
        configuration.background.backgroundColor = Colors.lightBlue
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = Fonts.headline
            outgoing.foregroundColor = Colors.white
            return outgoing
        }
        self.configuration = configuration
    }
}

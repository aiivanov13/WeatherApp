//
//  MainAssembly.swift
//  WeatherApp
//
//  Created by Александр Иванов on 20.02.2026.
//

import UIKit

struct MainAssembly {
    
    static func assemble() -> UIViewController {
        let networkService = URLSessionNetworkService()
        let network = MainNetwork(networkService: networkService)
        let service = MainService(network: network)
        let viewModel = MainViewModel(service: service)
        let localization = MainLocalization()
        let view = MainViewController(viewModel: viewModel, localization: localization)
        
        return view
    }
}

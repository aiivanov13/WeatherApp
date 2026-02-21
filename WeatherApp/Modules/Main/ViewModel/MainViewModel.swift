//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Александр Иванов on 20.02.2026.
//

import Observation

@Observable
@MainActor
final class MainViewModel {
    
    var name: String = ""
    
    private var lat = "55.753960"
    private var lon = "37.620393"
    
    // Dependencies
    private let service: MainServiceProtocol
    
    // Initializer
    init(service: MainServiceProtocol) {
        self.service = service
    }
}

// MARK: - Methods

extension MainViewModel {
    
    func getData() {
        Task {
            let current = try await service.fetchCurrentWeather(lat: lat, lon: lon)
            name = current.location.name
//            try await service.fetchForecastWeather(lat: lat, lon: lon, days: 3)
        }
    }
}

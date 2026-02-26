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
    
    private(set) var items: [WeatherCollection.Item] = []
    private(set) var isError = false
    private(set) var isLoading = false
    
    private var lat = "55.7540584"
    private var lon = "37.62049"
    
    // Dependencies
    private let service: MainServiceProtocol
    
    // Initializer
    init(service: MainServiceProtocol) {
        self.service = service
    }
}

// MARK: - Methods

extension MainViewModel {
    
    func loadData() {
        isLoading = true
        isError = false

        Task {
            do {
                let (lat, lon) = try await service.getLocation()
                self.lat = String(lat)
                self.lon = String(lon)
            } catch {
                print(error)
            }
            
            await fetchData()
            isLoading = false
        }
    }
    
    private func fetchData() async {
        do {
            items = try await service.fetchWeather(lat: lat, lon: lon, days: 3)
        } catch {
            isError = true
        }
    }
}

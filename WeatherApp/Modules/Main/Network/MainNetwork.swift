//
//  MainNetwork.swift
//  WeatherApp
//
//  Created by Александр Иванов on 20.02.2026.
//

import Foundation

// MARK: - Network Protocol

protocol MainNetworkProtocol: Sendable {
    
    func fetchWeather(lat: String, lon: String, days: Int) async throws -> ForecastWeatherResponse
}

// MARK: - Network Implementation

struct MainNetwork {
    
    // Dependencies
    private let networkService: NetworkService
    
    // Initializer
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

// MARK: - Protocol Implementation

extension MainNetwork: MainNetworkProtocol {
    
    func fetchWeather(lat: String, lon: String, days: Int) async throws -> ForecastWeatherResponse {
        try await networkService.request(WeatherAPI.forecast(q: "\(lat),\(lon)", days: "\(days)"))
    }
}

//
//  MainService.swift
//  WeatherApp
//
//  Created by Александр Иванов on 20.02.2026.
//

import Foundation

// MARK: - Service Protocol

protocol MainServiceProtocol: Sendable {
    
    func fetchCurrentWeather(lat: String, lon: String) async throws -> CurrentWeatherResponse
    func fetchForecastWeather(lat: String, lon: String, days: Int) async throws -> ForecastWeatherResponse
}

// MARK: - Service Implementation

struct MainService {
    
    // Dependencies
    private let network: MainNetworkProtocol
    
    // Initializer
    init(network: MainNetworkProtocol) {
        self.network = network
    }
}

// MARK: - Protocol Implementation

extension MainService: MainServiceProtocol {
    
    func fetchCurrentWeather(lat: String, lon: String) async throws -> CurrentWeatherResponse {
        try await network.fetchCurrentWeather(lat: lat, lon: lon)
    }
    
    func fetchForecastWeather(lat: String, lon: String, days: Int) async throws -> ForecastWeatherResponse {
        try await network.fetchForecastWeather(lat: lat, lon: lon, days: days)
    }
}

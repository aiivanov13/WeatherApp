//
//  MainService.swift
//  WeatherApp
//
//  Created by Александр Иванов on 20.02.2026.
//

import Foundation
import CoreLocation

// MARK: - Service Protocol

protocol MainServiceProtocol: Sendable {
    
    func fetchWeather(lat: String, lon: String, days: Int) async throws -> [WeatherCollection.Item]
    func getLocation() async throws -> (Double, Double)
}

// MARK: - Service Implementation

struct MainService {
    
    // Dependencies
    private let network: MainNetworkProtocol
    private let locationService: LocationServiceProtocol
    
    // Initializer
    init(network: MainNetworkProtocol, locationService: LocationServiceProtocol) {
        self.network = network
        self.locationService = locationService
    }
}

// MARK: - Protocol Implementation

extension MainService: MainServiceProtocol {
    
    func fetchWeather(lat: String, lon: String, days: Int) async throws -> [WeatherCollection.Item] {
        let forecast = try await network.fetchWeather(lat: lat, lon: lon, days: days)
        var items: [WeatherCollection.Item] = []
        
        items.append(
            .current(
                .init(
                    name: forecast.location.name,
                    tempC: forecast.current.tempC
                )
            )
        )
        
        var hoursItems: [WeatherCollection.Item] = []
        
        forecast.forecast.forecastday.dropLast().forEach {
            var currentHours = $0.hour
            currentHours.removeAll(where: { ($0.timeEpoch ?? 0) < forecast.location.localtimeEpoch })
            
            let hours: [WeatherCollection.Item] = currentHours.map {
                .hours(
                    .init(
                        hour: $0.timeEpoch,
                        tempC: $0.tempC,
                        tzID: forecast.location.tzID,
                        icon: $0.condition.icon
                    )
                )
            }
            hoursItems.append(contentsOf: hours)
        }
        
        let forecastItems: [WeatherCollection.Item] = forecast.forecast.forecastday.map {
            .forecast(
                .init(
                    date: $0.dateEpoch,
                    minTempC: $0.day.mintempC,
                    maxTempC: $0.day.maxtempC,
                    tzID: forecast.location.tzID,
                    icon: $0.day.condition.icon
                )
            )
        }
        
        items.append(contentsOf: hoursItems)
        items.append(contentsOf: forecastItems)
        
        return items
    }
    
    func getLocation() async throws -> (Double, Double) {
        return try await withCheckedThrowingContinuation { continuation in
            locationService.requestLocation { result in
                switch result {
                case .success(let success):
                    continuation.resume(returning: (success.coordinate.latitude, success.coordinate.longitude))
                case .failure(let failure):
                    continuation.resume(throwing: failure)
                }
            }
        }
    }
}

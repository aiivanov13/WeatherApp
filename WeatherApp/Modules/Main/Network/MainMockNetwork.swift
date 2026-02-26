//
//  MainMockNetwork.swift
//  WeatherApp
//
//  Created by Александр Иванов on 24.02.2026.
//

import Foundation

// MARK: - Mock Network Implementation

struct MainMockNetwork {

}

// MARK: - Protocol Implementation

extension MainMockNetwork: MainNetworkProtocol {
    
    func fetchWeather(lat: String, lon: String, days: Int) async throws -> ForecastWeatherResponse {
        guard let url = Bundle.main.url(forResource: "forecastMock", withExtension: "json") else { throw URLError.init(.badURL) }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(ForecastWeatherResponse.self, from: data)
    }
}

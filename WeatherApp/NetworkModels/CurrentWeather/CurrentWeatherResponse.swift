//
//  CurrentWeatherResponse.swift
//  WeatherApp
//
//  Created by Александр Иванов on 21.02.2026.
//

import Foundation

struct CurrentWeatherResponse: Codable {
    let location: Location
    let current: Current
}

struct Location: Codable {
    let name: String
}

struct Current: Codable {
    let tempC: Double
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
    }
}

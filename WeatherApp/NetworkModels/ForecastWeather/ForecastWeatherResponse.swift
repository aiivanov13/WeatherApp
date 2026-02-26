//
//  ForecastWeatherResponse.swift
//  WeatherApp
//
//  Created by Александр Иванов on 21.02.2026.
//

import Foundation

struct ForecastWeatherResponse: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

struct Location: Codable {
    let name: String
    let tzID: String
    let localtimeEpoch: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
    }
}

struct Current: Codable {
    let tempC: Double
    let timeEpoch: Int?
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case timeEpoch = "time_epoch"
        case condition
    }
}

struct Forecast: Codable {
    let forecastday: [Forecastday]
}

struct Forecastday: Codable {
    let dateEpoch: Int
    let day: Day
    let hour: [Current]
    
    enum CodingKeys: String, CodingKey {
        case dateEpoch = "date_epoch"
        case day, hour
    }
}

struct Day: Codable {
    let mintempC: Double
    let maxtempC: Double
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case mintempC = "mintemp_c"
        case maxtempC = "maxtemp_c"
        case condition
    }
}

struct Condition: Codable {
    let icon: String
}

//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Александр Иванов on 21.02.2026.
//

import Foundation

enum WeatherAPI {
    
    case current(q: String)
    case forecast(q: String, days: String)
}

// MARK: - Endpoint

extension WeatherAPI: Endpoint {
    
    var baseURL: URL {
        URL(string: ServerLinks.basePath)!
    }
    
    var path: String {
        switch self {
        case .current:
            "current.json"
        case .forecast:
            "forecast.json"
        }
    }
    
    var method: HTTPMethod { .GET }
    
    var headers: [String : String]? {
        [:]
    }
    
    var queryItems: [URLQueryItem]? {
        var query = [URLQueryItem(name: "key", value: APIKeys.weatherAPIKey)]
        
        switch self {
        case .current(let q):
            query.append(URLQueryItem(name: "q", value: q))
        case .forecast(let q, let days):
            query.append(contentsOf: [
                URLQueryItem(name: "q", value: q),
                URLQueryItem(name: "days", value: days)
            ])
        }
        
        return query
    }
    
    var body: Data? { nil }
}

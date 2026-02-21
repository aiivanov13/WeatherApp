//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Александр Иванов on 21.02.2026.
//

import Foundation

// MARK: - NetworkService

protocol NetworkService {
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

struct URLSessionNetworkService: NetworkService {
    
    func request<T>(_ endpoint: any Endpoint) async throws -> T where T : Decodable {
        try await NetworkClient().request(endpoint)
    }
}

// MARK: - NetworkClient

fileprivate struct NetworkClient {
    
    func request<T: Decodable>(
        _ endpoint: Endpoint,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        let request = try endpoint.makeRequest()
        let (data, response) = try await URLSession.shared.data(for: request)

        try validate(response: response)
        
        return try decoder.decode(T.self, from: data)
    }
    
    private func validate(response: URLResponse) throws {
        guard let http = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard 200..<300 ~= http.statusCode else {
            throw NetworkError.statusCode(http.statusCode)
        }
    }
}

// MARK: - NetworkError

enum NetworkError: Error {
    case statusCode(Int)
}

//
//  LocationService.swift
//  WeatherApp
//
//  Created by Александр Иванов on 22.02.2026.
//

import CoreLocation

protocol LocationServiceProtocol {
    
    func requestLocation(completion: @escaping (Result<CLLocation, Error>) -> Void)
}

final class LocationService: NSObject, LocationServiceProtocol {
    
    enum LocationError: Error {
        case permissionDenied
    }
    
    private let manager = CLLocationManager()
    private var completion: ((Result<CLLocation, Error>) -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation(completion: @escaping (Result<CLLocation, Error>) -> Void) {
        self.completion = completion
        
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        default:
            completion(.failure(LocationError.permissionDenied))
        }
    }
}

// MARK: Delegate

extension LocationService: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {        
        if manager.authorizationStatus == .authorizedWhenInUse ||
           manager.authorizationStatus == .authorizedAlways {
            manager.requestLocation()
        } else if manager.authorizationStatus == .denied {
            completion?(.failure(LocationError.permissionDenied))
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        completion?(.success(location))
        completion = nil
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        completion?(.failure(error))
        completion = nil
    }
}

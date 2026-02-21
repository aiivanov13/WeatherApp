//
//  LocationService.swift
//  WeatherApp
//
//  Created by Александр Иванов on 22.02.2026.
//

import CoreLocation

final class LocationService: NSObject {
    
    private let manager = CLLocationManager()
    private var streamContinuation: AsyncStream<CLLocation>.Continuation?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func locationUpdates() -> AsyncStream<CLLocation> {
        AsyncStream { [weak self] continuation in
            self?.streamContinuation = continuation
            self?.handleAuthorization()
            
            self?.manager.startUpdatingLocation()
            
//            continuation.onTermination = { [weak self] _ in
//                self?.manager.stopUpdatingLocation()
//                self?.streamContinuation = nil
//            }
        }
    }
    
    private func handleAuthorization() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            streamContinuation?.finish()
        case .authorizedWhenInUse, .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse ||
           manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        } else if manager.authorizationStatus == .denied || manager.authorizationStatus == .restricted {
            streamContinuation?.finish()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        streamContinuation?.yield(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        streamContinuation?.finish()
    }
}

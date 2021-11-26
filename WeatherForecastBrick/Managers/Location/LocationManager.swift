//
//  CLLocationManagerDelegate.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 24/10/2021.
//

import UIKit
import CoreLocation

typealias CompletionHandler = (Result<LocationCoordinate, Error>) -> Void

protocol LocationManagerProtocol {
    func requestLocation(completion: @escaping CompletionHandler)
}

class LocationManager: NSObject, LocationManagerProtocol {

    private let locationManager = CLLocationManager()
    private var shouldIgnoreAuthorizationChange = false
    private var locationRequestCompletion: (CompletionHandler)?

    override init() {
        super.init()
        configureLocationManager()
    }

    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation(completion: @escaping CompletionHandler) {
        if CLLocationManager.locationServicesEnabled() {
            locationRequestCompletion = completion
            if #available(iOS 14.0, *) {
                handleAutorizationStatus(locationManager.authorizationStatus)
            } else {
                handleAutorizationStatus(CLLocationManager.authorizationStatus())
            }
        } else {
            completion(.failure(LocationError.locationServicesDisabled))
        }
    }

    private func handleAutorizationStatus(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            shouldIgnoreAuthorizationChange = true
            locationRequestCompletion?(.failure(LocationError.locationServicesNotAuthorized))
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            shouldIgnoreAuthorizationChange = true
            locationManager.requestLocation()
        @unknown default:
            locationRequestCompletion?(.failure(LocationError.unknownStatus))
        }

    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async { [self] in
            if let location = locations.last {
                locationRequestCompletion?(.success(LocationCoordinate(coordinate: location.coordinate)))
            } else {
                locationRequestCompletion?(.failure(LocationError.locationNotFound))
            }
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if shouldIgnoreAuthorizationChange { return }
        DispatchQueue.main.async { [self] in
            if #available(iOS 14.0, *) {
                handleAutorizationStatus(locationManager.authorizationStatus)
            } else {
                handleAutorizationStatus(CLLocationManager.authorizationStatus())
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async { [self] in
            locationRequestCompletion?(.failure(error))
        }
    }
}

//
//  CLLocationManagerDelegate.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 24/10/2021.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    func locationUpdateDidFailWithError(error: Error)
}

class LocationManager: NSObject, CLLocationManagerDelegate {

    weak var delegate: LocationManagerDelegate?
    var locationManager = CLLocationManager()

    override init() {
        super.init()
        configureLocationManager()
    }

    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }

    func requestLocation() {
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            DispatchQueue.main.async { [self] in
                delegate?.didUpdateLocation(latitude: latitude, longitude: longitude)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async { [self] in
        delegate?.locationUpdateDidFailWithError(error: error)
        }
    }
}

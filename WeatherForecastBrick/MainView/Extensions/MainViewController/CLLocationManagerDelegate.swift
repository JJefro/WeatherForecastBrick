//
//  CLLocationManagerDelegate.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import UIKit
import CoreLocation

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            weatherManager.fetchData(latitude: latitude, longitude: longitude)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

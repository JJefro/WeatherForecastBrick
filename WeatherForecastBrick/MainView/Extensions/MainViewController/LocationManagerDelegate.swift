//
//  LocationManagerDelegate.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 03/11/2021.
//

import UIKit
import CoreLocation

extension MainViewController: LocationManagerDelegate {

    func didUpdateLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        weatherManager.fetchWeatherByLocation(latitude: latitude, longitude: longitude)
    }

    func locationUpdateDidFailWithError(error: Error) {
        loadingView.isHidden = true
        brickImageView.isHidden = true
        searchButton.isEnabled = false
        currentLocationButton.isEnabled = true
        
        let alert = UIAlertController(title: "Location Manager", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        alert.showAlert()
    }
}

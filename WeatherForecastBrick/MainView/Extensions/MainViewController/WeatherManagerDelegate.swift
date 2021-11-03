//
//  WeatherManagerDelegate.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation
import UIKit

extension MainViewController: WeatherManagerDelegate {
    
    func willFetchWeather() {
        loadingView.isHidden = false
        brickImageView.isHidden = true
    }

    func updateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        guard let area = weather.country else {return}
        temperatureLabel.text = weather.tempString
        weatherCondition.text = weather.condition.condition
        areaLabel.text = "\(weather.cityName), \(area)"
        currentCity = weather.cityName

        UIView.transition(with: brickImageView, duration: 1, options: [.transitionCrossDissolve]) { [self] in
            brickImageView.image = brickModel.changeBrickCondition(brickImageView, weather: weather)
        } completion: { [self] _ in
            brickModel.setBrickAnimation(brickImageView)
            searchButton.isEnabled = true
            loadingView.isHidden = true
            brickImageView.isHidden = false
        }
    }

    func didFailWithError(error: Error) {
        // If we have a problem with internet connection, brick disappears and we present alert with error.
        loadingView.isHidden = true
        brickImageView.isHidden = true
        searchButton.isEnabled = false
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        alert.showAlert()
    }
}

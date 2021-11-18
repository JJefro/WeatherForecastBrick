//
//  WeatherManagerDelegate.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation
import UIKit

extension MainViewController: WeatherModelDelegate {
    
    func weatherModel(_ weatherModel: WeatherModelProtocol, willUpdate weather: WeatherEntity?) {
        loadingView.isHidden = false
    }

    func weatherModel(_ weatherModel: WeatherModelProtocol, didUpdate weather: WeatherEntity) {
        guard let area = weather.country else {return}
        temperatureLabel.text = weather.tempString
        weatherConditionLabel.text = weather.condition.condition
        areaLabel.text = "\(weather.cityName), \(area)"

        UIView.transition(with: brickImageView, duration: 1, options: [.transitionCrossDissolve]) { [self] in
            brickImageView.image = brickModel.changeBrickCondition(weather: weather)
        } completion: { [self] _ in
            searchButton.isEnabled = true
            loadingView.isHidden = true
            currentLocationButton.isEnabled = true
            brickImageView.isHidden = false
            UIView.transition(with: brickImageView, duration: 0.5, options: [.transitionCrossDissolve]) { [self] in
                brickModel.setBrickAnimation()
            }
        }
    }

    func weatherModel(_ weatherModel: WeatherModelProtocol, errorOccured error: Error) {
        // If we have a problem with internet connection, brick disappears and we present alert with error.
        loadingView.isHidden = true
        brickImageView.isHidden = true
        currentLocationButton.isEnabled = true
        showAlert(withTitle: nil, withMessage: error.localizedDescription, dismissAfter: false)
    }
    
    func getErrorFromServer(_ error: WeatherError) {
        loadingView.isHidden = true
        brickImageView.isHidden = true
        currentLocationButton.isEnabled = true
        showAlert(withTitle: error.cod, withMessage: error.message, dismissAfter: false)
    }
}

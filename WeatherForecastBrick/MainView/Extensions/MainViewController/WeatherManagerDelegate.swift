//
//  WeatherManagerDelegate.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation

extension MainViewController: WeatherManagerDelegate {
    func updateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async { [self] in
            guard let area = weather.country else {return}
            temperatureLabel.text = weather.tempString
            weatherCondition.text = weather.conditionName
            changeBrickCondition(condition: weather.conditionName, feelsLike: weather.temperatureFeelsLike)
            place.text = "\(weather.cityName), \(area)"
            loadingView.isHidden = true
        }
    }

    private func changeBrickCondition(condition: String, feelsLike: Double) {
        switch condition {
        case WeatherCondition.raining:
            brickImage.image = R.image.mainView.brick.wetBrick()
        case WeatherCondition.sunny:
            brickImage.image = R.image.mainView.brick.normalBrick()
        case WeatherCondition.snow:
            brickImage.image = R.image.mainView.brick.snowBrick()
        case WeatherCondition.fog:
            brickImage.layer.zPosition = -1
            brickImage.layer.opacity = 0.05
        default: break
        }
    }
}

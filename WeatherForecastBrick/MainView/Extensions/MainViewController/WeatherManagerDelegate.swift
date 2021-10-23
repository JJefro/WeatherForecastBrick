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
            place.text = "\(weather.cityName), \(area)"

            changeBrickCondition(
                condition: weather.conditionName,
                feelsLike: weather.temperatureFeelsLike,
                visibility: weather.visibility
            )
            loadingView.isHidden = true
            print(weather.windSpeed)
        }
    }

    func didFailWithError(error: Error) {
        // If we have a problem with internet connection, brick disappears.
        brickImage.isHidden = true
        loadingView.isHidden = true
        print(error.localizedDescription)
    }

    private func changeBrickCondition(condition: String, feelsLike: Double, visibility: Int) {
        // If there is no problem with internet connection, brick appears.
        brickImage.isHidden = false
        if condition == WeatherCondition.sunny, feelsLike > 30 {
            brickImage.image = R.image.mainView.brick.cracksBrick()
        } else {
            switch condition {
            case WeatherCondition.thunderstorm:
                brickImage.image = R.image.mainView.brick.wetBrick()
            case WeatherCondition.raining:
                brickImage.image = R.image.mainView.brick.wetBrick()
            case WeatherCondition.drizzle:
                brickImage.image = R.image.mainView.brick.wetBrick()
            case WeatherCondition.tornado:
                brickImage.image = R.image.mainView.brick.normalBrick()
            case WeatherCondition.clouds:
                brickImage.image = R.image.mainView.brick.normalBrick()
            case WeatherCondition.sunny:
                brickImage.image = R.image.mainView.brick.normalBrick()
            case WeatherCondition.snow:
                brickImage.image = R.image.mainView.brick.snowBrick()
            case WeatherCondition.fog:
                brickImage.layer.zPosition = -1
                changeBrickVisibility(visibility)
            default: break
            }
        }
    }

    private func changeBrickVisibility(_ visibility: Int) {
        switch visibility {
        case  20_000...:
            brickImage.alpha = 1
        case 10_000...19_999:
            brickImage.alpha = 0.9
        case 4_000...9_999:
            brickImage.alpha = 0.7
        case 2_000...3_999:
            brickImage.alpha = 0.6
        case 1_000...1_999:
            brickImage.alpha = 0.4
        case 500...999:
            brickImage.alpha = 0.3
        case 200...499:
            brickImage.alpha = 0.2
        case 50...199:
            brickImage.alpha = 0.1
        default: brickImage.alpha = 0.05
        }
    }
}

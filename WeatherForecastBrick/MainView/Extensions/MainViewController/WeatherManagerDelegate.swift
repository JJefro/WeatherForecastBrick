//
//  WeatherManagerDelegate.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation
import UIKit

extension MainViewController: WeatherManagerDelegate {

    func updateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        guard let area = weather.country else {return}
        temperatureLabel.text = weather.tempString
        weatherCondition.text = weather.condition.condition
        areaLabel.text = "\(weather.cityName), \(area)"
        currentCity = weather.cityName

        UIView.transition(with: brickImage, duration: 1, options: [.transitionCrossDissolve]) { [self] in
            changeBrickCondition(
                condition: weather.condition,
                tempFeelsLike: weather.temperatureFeelsLike,
                visibility: weather.visibility
            )
        } completion: { [self] _ in
            setBrickAnimation(with: weather.windSpeed)
            searchButton.isEnabled = true
            loadingView.isHidden = true
            brickImage.isHidden = false
        }
    }

    func didFailWithError(error: Error) {
        // If we have a problem with internet connection, brick disappears and we present Alert with error.
        DispatchQueue.main.async { [self] in
            brickImage.isHidden = true
            loadingView.isHidden = true
            searchButton.isEnabled = false
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            alert.showAlert()
        }
    }

    private func changeBrickCondition(condition: Weather, tempFeelsLike: Double, visibility: Int) {
        // If there is no problem with internet connection, brick appears.
        brickImage.isHidden = false

        if condition == .sunny, tempFeelsLike > 29 {
            brickImage.image = R.image.mainView.brick.cracksBrick()
        } else {
            switch condition {
            case .thunderstorm:
                brickImage.image = R.image.mainView.brick.wetBrick()
            case .raining:
                brickImage.image = R.image.mainView.brick.wetBrick()
            case .drizzle:
                brickImage.image = R.image.mainView.brick.wetBrick()
            case .tornado:
                brickImage.image = R.image.mainView.brick.normalBrick()
            case .clouds:
                brickImage.image = R.image.mainView.brick.normalBrick()
            case .sunny:
                brickImage.image = R.image.mainView.brick.normalBrick()
            case .snow:
                brickImage.image = R.image.mainView.brick.snowBrick()
            case .fog:
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

    private func setBrickAnimation(with windForce: Double) {
        let numberOfFrames: Double = 2
        let frameDuration = Double(1 / numberOfFrames)
        if windForce > 5 {
            brickImage.setAnchorPoint(CGPoint(x: 0.5, y: -0.5))
            UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction]) {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: frameDuration) {
                    self.brickImage.transform = CGAffineTransform(rotationAngle: .pi / 8)
                }
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: frameDuration * 2) {
                    self.brickImage.transform = CGAffineTransform(rotationAngle: -(.pi / 8))
                }
            }
        } else {
            brickImage.layer.removeAllAnimations()
        }
    }
}

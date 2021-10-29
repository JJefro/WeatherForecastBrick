//
//  Animations.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 26/10/2021.
//

import Foundation
import UIKit

extension MainViewController {

    func animateSearchView() {
        UIView.animate(withDuration: 1, delay: 0, options: []) { [self] in
            if searchView.isHidden == false {
                brickImage.transform = CGAffineTransform(translationX: 0, y: -300)
                temperatureLabel.transform = CGAffineTransform(translationX: -300, y: 0)
                weatherCondition.transform = CGAffineTransform(translationX: -300, y: 0)
                info.transform = CGAffineTransform(translationX: 0, y: 300)
                infoTitle.transform = CGAffineTransform(translationX: 0, y: 300)
                searchView.transform = CGAffineTransform(translationX: 0, y: -view.frame.size.height / 2)
            } else {
                brickImage.transform = .identity
                temperatureLabel.transform = .identity
                weatherCondition.transform = .identity
                info.transform = .identity
                infoTitle.transform = .identity
                searchView.transform = .identity
            }
        }
    }

    func animateInfoView() {
        UIView.animate(withDuration: 1, delay: 0, options: [.allowUserInteraction]) { [self] in
            if infoView.isHidden == false {
                brickImage.transform = CGAffineTransform(translationX: 0, y: -300)
                temperatureLabel.transform = CGAffineTransform(translationX: -300, y: 0)
                weatherCondition.transform = CGAffineTransform(translationX: -300, y: 0)
                info.transform = CGAffineTransform(translationX: 0, y: 300)
                infoTitle.transform = CGAffineTransform(translationX: 0, y: 300)
                areaLabel.transform = CGAffineTransform(translationX: 0, y: 300)
                searchButton.transform = CGAffineTransform(translationX: 0, y: 300)
                currentLocationButton.transform = CGAffineTransform(translationX: 0, y: 300)
            } else {
                brickImage.transform = .identity
                temperatureLabel.transform = .identity
                weatherCondition.transform = .identity
                info.transform = .identity
                infoTitle.transform = .identity
                areaLabel.transform = .identity
                searchButton.transform = .identity
                currentLocationButton.transform = .identity
            }
        }
    }
}

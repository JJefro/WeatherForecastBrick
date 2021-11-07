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
                brickModel.state = .brickWentUp
                brickImageView.transform = CGAffineTransform(translationX: 0, y: -300)
                temperatureLabel.transform = CGAffineTransform(translationX: -300, y: 0)
                weatherConditionLabel.transform = CGAffineTransform(translationX: -300, y: 0)
                infoImageView.transform = CGAffineTransform(translationX: 0, y: 300)
                infoTitle.transform = CGAffineTransform(translationX: 0, y: 300)
                searchView.transform = CGAffineTransform(translationX: 0, y: (-view.frame.size.height / 2) - 50)
            } else {
                returnElementsBack()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    brickModel.state = .brickCalmedDown
                }
            }
        }
    }
    
    func animateInfoView() {
        UIView.animate(withDuration: 1, delay: 0, options: []) { [self] in
            if infoView.isHidden == false {
                brickModel.state = .brickWentUp
                brickImageView.transform = CGAffineTransform(translationX: 0, y: -300)
                temperatureLabel.transform = CGAffineTransform(translationX: -300, y: 0)
                weatherConditionLabel.transform = CGAffineTransform(translationX: -300, y: 0)
                infoImageView.transform = CGAffineTransform(translationX: 0, y: 300)
                infoTitle.transform = CGAffineTransform(translationX: 0, y: 300)
                areaLabel.transform = CGAffineTransform(translationX: 0, y: 300)
                searchButton.transform = CGAffineTransform(translationX: 0, y: 300)
                currentLocationButton.transform = CGAffineTransform(translationX: 0, y: 300)
            } else {
                returnElementsBack()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    brickModel.state = .brickCalmedDown
                }
            }
        }
    }
    
    private func returnElementsBack() {
        brickImageView.transform = .identity
        temperatureLabel.transform = .identity
        weatherConditionLabel.transform = .identity
        infoImageView.transform = .identity
        infoTitle.transform = .identity
        areaLabel.transform = .identity
        searchButton.transform = .identity
        currentLocationButton.transform = .identity
    }
}

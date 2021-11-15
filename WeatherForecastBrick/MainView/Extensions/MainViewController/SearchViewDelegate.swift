//
//  SearchViewDelegate.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 03/11/2021.
//

import Foundation
import UIKit

extension MainViewController: SearchViewDelegate {

    func getSearchViewText(text: String) {
        model.updateWeatherAt(city: text)
        searchView.isHidden = true
        animateSearchView()
        if text.isEmpty {
            showAlert(withTitle: nil, withMessage: "Weather update", dismissAfter: true)
        }
    }
}

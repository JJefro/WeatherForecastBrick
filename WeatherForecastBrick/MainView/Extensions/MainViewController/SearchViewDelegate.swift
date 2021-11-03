//
//  SearchViewDelegate.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 03/11/2021.
//

import Foundation

extension MainViewController: SearchViewDelegate {

    func getSearchViewText(text: String) {
        if !text.isEmpty {
            weatherManager.fetchWeatherByCityName(cityName: text)
        } else {
            weatherManager.fetchWeatherByCityName(cityName: currentCity)
        }
        searchView.isHidden = true
        animateSearchView()
    }
}

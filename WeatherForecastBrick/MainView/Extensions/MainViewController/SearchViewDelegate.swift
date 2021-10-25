//
//  SearchViewDelegate.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 24/10/2021.
//

import Foundation

extension MainViewController: SearchViewDelegate {

    func getSearchViewText(text: String) {
        weatherManager.fetchWeatherByCityName(cityName: text)
        searchView.isHidden = true
        animateSearchView()
    }
}

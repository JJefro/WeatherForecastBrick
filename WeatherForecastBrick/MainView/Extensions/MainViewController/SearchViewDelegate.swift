//
//  SearchViewDelegate.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 03/11/2021.
//

import Foundation

extension MainViewController: SearchViewDelegate {

    func getSearchViewText(text: String) {
        weatherManager.fetchWeatherByCityName(cityName: !text.isEmpty ? text : currentCity)
        searchView.isHidden = true
        animateSearchView()
    }
}

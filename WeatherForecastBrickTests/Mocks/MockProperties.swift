//
//  MockProperties.swift
//  WeatherForecastBrickTests
//
//  Created by Jevgenijs Jefrosinins on 23/11/2021.
//

import Foundation
@testable import WeatherForecastBrick

struct MockProperties {
    let lat = 56.9496
    let lon = 24.1052

    let cityURL = "ciryURL"
    let URL = "www.example.com"
    let city: NSString = "Riga"

    let mockWeather: WeatherEntity? = WeatherEntity(
        conditionID: 600,
        visibility: 10_000,
        cityName: "Riga",
        temperature: -99,
        countryCode: "lv",
        windSpeed: 5,
        temperatureFeelsLike: -100)
}

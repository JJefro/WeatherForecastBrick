//
//  WeatherModel.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation

struct WeatherEntity {

    let conditionID: Int
    let visibility: Int
    let cityName: String
    let temperature: Double
    let countryCode: String
    let windSpeed: Double
    let temperatureFeelsLike: Double
    
    var tempString: String {
        let temp = String(format: "%.0f", temperature)
        return "\(temp)°"
    }

    var country: String? {
        let current = Locale(identifier: "en-US")
        return current.localizedString(forRegionCode: countryCode)
    }

    var condition: Weather {
        return Weather(condition: conditionID)
    }
}

extension WeatherEntity {
    init(data: WeatherData) {
        conditionID = data.weather[0].id
        visibility  = data.visibility
        cityName    = data.name
        temperature = data.main.temp
        countryCode = data.sys.country
        windSpeed   = data.wind.speed
        temperatureFeelsLike = data.main.feels_like
    }
}

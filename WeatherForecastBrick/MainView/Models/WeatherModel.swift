//
//  WeatherModel.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation

struct WeatherModel {

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

    var conditionName: String {
        switch conditionID {
        case 200...299:
            return WeatherCondition.thunderstorm
        case 300...399:
            return WeatherCondition.drizzle
        case 500...599:
            return WeatherCondition.raining
        case 600...699:
            return WeatherCondition.snow
        case 700...780:
            return WeatherCondition.fog
        case 781:
            return WeatherCondition.tornado
        case 800:
            return WeatherCondition.sunny
        case 801...899:
            return WeatherCondition.clouds
        default: return "Unknown conditionID"
        }
    }
}

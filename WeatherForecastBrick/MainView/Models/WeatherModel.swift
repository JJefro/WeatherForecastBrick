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

    var condition: Weather {
        switch conditionID {
        case 200 ... 299:
            return .thunderstorm
        case 300 ... 399:
            return .drizzle
        case 500 ... 599:
            return .raining
        case 600 ... 699:
            return .snow
        case 700 ... 780:
            return .fog
        case 781:
            return .tornado
        case 800:
            return .sunny
        case 801 ... 899:
            return .clouds
        default: return .unknown
        }
    }
}

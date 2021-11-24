//
//  WeatherModel.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation

struct WeatherEntity: Equatable {

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
        conditionID = data.weather[0].identifier
        visibility  = data.visibility
        cityName    = data.cityName
        temperature = data.main.temperature
        countryCode = data.sys.countryCode
        windSpeed   = data.wind.speed
        temperatureFeelsLike = data.main.feelsLike
    }
}

#if DEBUG
extension WeatherEntity {
    static var mockRain: Self {
        .init(conditionID: 500, visibility: 10_000, cityName: "London", temperature: 10, countryCode: "uk", windSpeed: 10, temperatureFeelsLike: 5)
    }

    static var mockSnow: Self {
        .init(conditionID: 600, visibility: 10_000, cityName: "Riga", temperature: -99, countryCode: "lv", windSpeed: 5, temperatureFeelsLike: -100)
    }

    static var mockWind: Self {
        .init(conditionID: 781, visibility: 5_000, cityName: "Florida", temperature: 20, countryCode: "us", windSpeed: 35, temperatureFeelsLike: 21)
    }

    static var mockThunderstorm: Self {
        .init(conditionID: 200, visibility: 5_000, cityName: "Moscow", temperature: 13, countryCode: "ru", windSpeed: 23, temperatureFeelsLike: 9)
    }

    static var mockFog: Self {
        .init(conditionID: 700, visibility: 100, cityName: "London", temperature: 8, countryCode: "uk", windSpeed: 0, temperatureFeelsLike: 4)
    }

    static var mockSunny: Self {
        .init(conditionID: 800, visibility: 20_000, cityName: "Abu Dhabi", temperature: 35, countryCode: "ae", windSpeed: 3, temperatureFeelsLike: 30)
    }
}
#endif

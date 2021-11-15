//
//  WeatherData.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation

struct WeatherData: Codable {

    let cityName: String
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let wind: Wind
    let sys: Sys

    struct Weather: Codable {
        let identifier: Int

        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
        }
    }

    struct Wind: Codable {
        let speed: Double
    }
    
    struct Main: Codable {
        let temperature: Double
        let feelsLike: Double

        private enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case feelsLike = "feelsLike"
        }
    }

    struct Sys: Codable {
        let countryCode: String

        private enum CodingKeys: String, CodingKey {
            case countryCode = "country"
        }
    }

    private enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case weather
        case main
        case visibility
        case wind
        case sys
    }
}

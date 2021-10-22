//
//  WeatherData.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation

struct WeatherData: Codable {

    let name: String
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys

    struct Weather: Codable {
        let id: Int
        let description: String
    }

    struct Wind: Codable {
        let speed: Double
    }
    
    struct Main: Codable {
        let temp: Double
        let feels_like: Double
    }

    struct Sys: Codable {
        let country: String
    }
}

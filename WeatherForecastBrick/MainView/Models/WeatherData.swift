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

    struct Weather: Codable {
        let id: Int
        let description: String
    }
    
    struct Main: Codable {
        let temp: Double
    }
}

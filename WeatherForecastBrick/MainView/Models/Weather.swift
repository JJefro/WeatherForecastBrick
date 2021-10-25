//
//  WeatherCondition.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation

enum Weather {
    case thunderstorm
    case drizzle
    case raining
    case snow
    case fog
    case tornado
    case sunny
    case clouds
    case unknown

    var condition: String {
        switch self {
        case .thunderstorm:
            return "thunderstorm"
        case .drizzle:
            return "drizzle"
        case .raining:
            return "raining"
        case .snow:
            return "snow"
        case .fog:
            return "fog"
        case .tornado:
            return "tornado"
        case .sunny:
            return "sunny"
        case .clouds:
            return "clouds"
        case .unknown:
            return "unknown"
        }
    }
}

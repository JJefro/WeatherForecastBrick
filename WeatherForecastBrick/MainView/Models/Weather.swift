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

    init?(condition: Int) {
        switch condition {
        case 200...299:    self = .thunderstorm
        case 300...399:    self = .drizzle
        case 500...599:    self = .raining
        case 600...699:    self = .snow
        case 700...780:    self = .fog
        case 781:          self = .tornado
        case 800:          self = .sunny
        case 801...899:    self = .clouds
        default:           self = .unknown
        }
    }

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

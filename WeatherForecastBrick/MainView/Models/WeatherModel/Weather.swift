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
            return R.string.localizable.weatherCondition_thunderstorm()
        case .drizzle:
            return R.string.localizable.weatherCondition_drizzle()
        case .raining:
            return R.string.localizable.weatherCondition_raining()
        case .snow:
            return R.string.localizable.weatherCondition_snow()
        case .fog:
            return R.string.localizable.weatherCondition_fog()
        case .tornado:
            return R.string.localizable.weatherCondition_tornado()
        case .sunny:
            return R.string.localizable.weatherCondition_sunny()
        case .clouds:
            return R.string.localizable.weatherCondition_clouds()
        case .unknown:
            return R.string.localizable.weatherCondition_unknown()
        }
    }
}

extension Weather {
    
    init(condition: Int) {
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
}

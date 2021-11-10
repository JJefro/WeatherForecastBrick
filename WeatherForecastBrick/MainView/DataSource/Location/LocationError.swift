//
//  LocationError.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 10/11/2021.
//

import Foundation

enum LocationError: Error {
    case locationNotFound
    case locationServicesDisabled
    case locationServicesNotAuthorized
    case unknownStatus
}

extension LocationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .locationNotFound:
            return "Location not found. Try again later or use the search."
        case .locationServicesDisabled:
            return "Location services disabled. Enable them in settings."
        case .locationServicesNotAuthorized:
            return "Location services not authorized. Grant acces in settings."
        case .unknownStatus:
            return "Unknown location status."
        }
    }
}

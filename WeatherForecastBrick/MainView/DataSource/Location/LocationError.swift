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
            return R.string.localizable.locationError_locationNotFound()
        case .locationServicesDisabled:
            return R.string.localizable.locationError_locationServicesDisabled()
        case .locationServicesNotAuthorized:
            return R.string.localizable.locationError_locationServicesNotAuthorized()
        case .unknownStatus:
            return R.string.localizable.locationError_unknownStatus()
        }
    }
}

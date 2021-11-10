//
//  LocationCoordinate.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 10/11/2021.
//

import Foundation
import CoreLocation

struct LocationCoordinate {
    let lat: Double
    let lon: Double
}

extension LocationCoordinate {
    init(coordinate: CLLocationCoordinate2D) {
        self.init(lat: coordinate.latitude, lon: coordinate.longitude)
    }
}

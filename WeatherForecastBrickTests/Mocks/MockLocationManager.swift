//
//  MockLocationManager.swift
//  WeatherForecastBrickTests
//
//  Created by Jevgenijs Jefrosinins on 23/11/2021.
//

@testable import WeatherForecastBrick

final class LocationManagerMock: LocationManagerProtocol {

    private var properties = MockProperties()
    var error: Error?

    func requestLocation(completion: @escaping CompletionHandler) {
        guard let error = error else {
            let locationCoordinate = LocationCoordinate(lat: properties.lat, lon: properties.lon)
            completion(.success(locationCoordinate))
            return
        }
        completion(.failure(error))
    }
}

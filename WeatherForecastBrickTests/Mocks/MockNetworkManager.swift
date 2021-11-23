//
//  MockNetworkManager.swift
//  WeatherForecastBrickTests
//
//  Created by Jevgenijs Jefrosinins on 23/11/2021.
//

import Foundation
@testable import WeatherForecastBrick

final class NetworkManagerMock: NetworkManagerProtocol {

    weak var delegate: NetworkManagerDelegate?
    private var properties = MockProperties()

    var latitude: Double?
    var longitude: Double?

    var city: NSString?
    var urlString: String?

    var error: Error?

    func getWeatherFrom(lat: Double, lon: Double, completion: @escaping WeatherCompletion) {
        latitude = lat
        longitude = lon
        performRequest(with: properties.URL, completion: completion)
    }

    func getWeatherAt(city: NSString, completion: @escaping WeatherCompletion) {
        self.city = city
        performRequest(with: properties.cityURL, completion: completion)
    }

    func performRequest(with urlString: String, completion: @escaping Completion) {
        self.urlString = urlString

        guard let error = error else {

            guard let city = city else {return}
            let weatherEntity = WeatherEntity(
                conditionID: 600,
                visibility: 10_000,
                cityName: "\(city)",
                temperature: -99,
                countryCode: "lv",
                windSpeed: 5,
                temperatureFeelsLike: -100)
            completion(.success(weatherEntity))
            return
        }
        completion(.failure(error))
    }
}

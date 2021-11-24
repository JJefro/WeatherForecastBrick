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
        self.latitude = lat
        self.longitude = lon
        performRequest(with: properties.URL) { result in
           completion(result)
        }
    }

    func getWeatherAt(city: NSString, completion: @escaping WeatherCompletion) {
        self.city = city
        performRequest(with: properties.cityURL) { result in
            completion(result)
        }
    }

    func performRequest(with urlString: String, completion: @escaping Completion) {
        self.urlString = urlString

        guard let error = error else {
            completion(.success(properties.mockWeather!))
            return
        }
        completion(.failure(error))
    }
}

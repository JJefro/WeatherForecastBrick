//
//  MockWeatherModel.swift
//  WeatherForecastBrickTests
//
//  Created by Jevgenijs Jefrosinins on 22/11/2021.
//

@testable import WeatherForecastBrick

class MockWeatherModel: WeatherModelProtocol {

    let mockWeather: WeatherEntity
    weak var delegate: WeatherModelDelegate?

    init(mockWeather: WeatherEntity) {
        self.mockWeather = mockWeather
    }

    func updateWeatherAtCurrentLocation() {
        delegate?.weatherModel(self, didUpdate: mockWeather)
    }

    func updateWeatherAt(city: String) {
    }

    func updateWeatherAtCity() {
    }
}

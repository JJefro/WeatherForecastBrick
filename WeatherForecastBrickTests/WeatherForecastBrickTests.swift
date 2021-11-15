//
//  WeatherForecastBrickTests.swift
//  WeatherForecastBrickTests
//
//  Created by Jevgenijs Jefrosinins on 07/11/2021.
//

import XCTest
import SnapshotTesting
@testable import WeatherForecastBrick

class WeatherForecastBrickTests: XCTestCase {

    func test_weatherRain() throws {
        let sut = sutBuild(weather: .mockRain)
        assertSnapshot(matching: sut, as: .image)
    }

    func test_weatherSnow() throws {
        let sut = sutBuild(weather: .mockSnow)
        assertSnapshot(matching: sut, as: .image)
    }

    func test_weatherWindy() throws {
        let sut = sutBuild(weather: .mockWind)
        assertSnapshot(matching: sut, as: .image)
    }

    func test_thunderstorm() throws {
        let sut = sutBuild(weather: .mockThunderstorm)
        assertSnapshot(matching: sut, as: .image)
    }

    func test_fog() throws {
        let sut = sutBuild(weather: .mockFog)
        assertSnapshot(matching: sut, as: .image)
    }

    func test_sunny() throws {
        let sut = sutBuild(weather: .mockSunny)
        assertSnapshot(matching: sut, as: .image)
    }

    private func sutBuild(weather: WeatherEntity) -> UIViewController {
        let mockModel = MockWeatherModel(mockWeather: weather)
        let sut = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() as! MainViewController
        sut.model = mockModel
        return sut
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}

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

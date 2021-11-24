//
//  WeatherForecastBrickTests.swift
//  WeatherForecastBrickTests
//
//  Created by Jevgenijs Jefrosinins on 16/11/2021.
//

import XCTest
@testable import WeatherForecastBrick

class WeatherForecastBrickTests: XCTestCase {

    private var properties = MockProperties()

    var locationManagerMock: LocationManagerMock!
    var networkManagerMock: NetworkManagerMock!
    var model: WeatherModel!
    var sut: MainViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        locationManagerMock = LocationManagerMock()
        networkManagerMock = NetworkManagerMock()
        model = WeatherModel(locationService: locationManagerMock, networkService: networkManagerMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        model = nil
        networkManagerMock = nil
        locationManagerMock = nil
        try super.tearDownWithError()
    }

    func test_updateWeatherAtCurrentLocation() throws {
        model.updateWeatherAtCurrentLocation()
        let result = model.weather
        XCTAssertEqual(result, properties.mockWeather)
    }

    func test_updateWeatherAtCity() throws {
        model.updateWeatherAt(city: properties.city as String)
        let result = model.weather
        XCTAssertEqual(result, properties.mockWeather)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

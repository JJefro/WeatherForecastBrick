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

    override func setUpWithError() throws {
        try super.setUpWithError()
        locationManagerMock = LocationManagerMock()
        networkManagerMock = NetworkManagerMock()
        model = WeatherModel(locationService: locationManagerMock, network: networkManagerMock)
    }

    override func tearDownWithError() throws {
        model = nil
        networkManagerMock = nil
        locationManagerMock = nil
        try super.tearDownWithError()
    }

    func test_updateWeatherAtCurrentLocation() throws {
        model.updateWeatherAtCurrentLocation()
        XCTAssertEqual(networkManagerMock.latitude, properties.lat)
        XCTAssertEqual(networkManagerMock.longitude, properties.lon)
        XCTAssertEqual(networkManagerMock.urlString, properties.URL)
    }

    func test_updateWeatherAtCity() throws {
        model.updateWeatherAt(city: "Riga")
        XCTAssertNil(networkManagerMock.latitude)
        XCTAssertNil(networkManagerMock.longitude)
        XCTAssertEqual(networkManagerMock.urlString, properties.cityURL)
        XCTAssertEqual(networkManagerMock.city, "Riga")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

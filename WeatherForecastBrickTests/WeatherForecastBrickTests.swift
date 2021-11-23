//
//  WeatherForecastBrickTests.swift
//  WeatherForecastBrickTests
//
//  Created by Jevgenijs Jefrosinins on 16/11/2021.
//

import XCTest
@testable import WeatherForecastBrick

class WeatherForecastBrickTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

class MockNetworkManager: NetworkManagerProtocol {

    weak var delegate: NetworkManagerDelegate?

    let data: Data?
    let response: URLResponse?
    let error: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    func getWeatherFrom(lat: Double, lon: Double, completion: @escaping WeatherCompletion) {

    }

    func getWeatherAt(city: NSString, completion: @escaping WeatherCompletion) {

    }

    func performRequest(with urlString: String, completion: @escaping Completion) {

    }
}

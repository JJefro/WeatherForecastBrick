//
//  WeatherForecastBrickTests.swift
//  WeatherForecastBrickTests
//
//  Created by Jevgenijs Jefrosinins on 07/11/2021.
//

import XCTest
import SnapshotTesting
@testable import WeatherForecastBrick

class WeatherForecastBrickSnapshotTests: XCTestCase {

    private func sutBuild(weather: WeatherEntity) -> UIViewController {
        let mockModel = MockWeatherModel(mockWeather: weather)
        let sut = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() as! MainViewController
        sut.model = mockModel
        return sut
    }

    func test_weatherRain() throws {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            let sut = sutBuild(weather: .mockRain)
            assertSnapshot(matching: sut, as: .image(on: .iPhone8), named: "iPhone8_darkMode")
            assertSnapshot(matching: sut, as: .image(on: .iPhoneXr), named: "iPhoneXr_darkMode")
        } else {
            let sut = sutBuild(weather: .mockRain)
            assertSnapshot(matching: sut, as: .image(on: .iPhone8), named: "iPhone8_lightMode")
            assertSnapshot(matching: sut, as: .image(on: .iPhoneXr), named: "iPhoneXr_lightMode")
        }
    }

    func test_weatherSnow() throws {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            let sut = sutBuild(weather: .mockSnow)
            assertSnapshot(matching: sut, as: .image(on: .iPhone8), named: "iPhone8_darkMode")
            assertSnapshot(matching: sut, as: .image(on: .iPhoneXr), named: "iPhoneXr_darkMode")
        } else {
            let sut = sutBuild(weather: .mockSnow)
            assertSnapshot(matching: sut, as: .image(on: .iPhone8), named: "iPhone8_lightMode")
            assertSnapshot(matching: sut, as: .image(on: .iPhoneXr), named: "iPhoneXr_lightMode")
        }
    }

    func test_weatherWindy() throws {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            let sut = sutBuild(weather: .mockWind)
            assertSnapshot(matching: sut, as: .image(on: .iPhone8), named: "iPhone8_darkMode")
            assertSnapshot(matching: sut, as: .image(on: .iPhoneXr), named: "iPhoneXr_darkMode")
        } else {
            let sut = sutBuild(weather: .mockWind)
            assertSnapshot(matching: sut, as: .image(on: .iPhone8), named: "iPhone8_lightMode")
            assertSnapshot(matching: sut, as: .image(on: .iPhoneXr), named: "iPhoneXr_lightMode")
        }
    }

    func test_thunderstorm() throws {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            let sut = sutBuild(weather: .mockThunderstorm)
            assertSnapshot(matching: sut, as: .image(on: .iPhone8), named: "iPhone8_darkMode")
            assertSnapshot(matching: sut, as: .image(on: .iPhoneXr), named: "iPhoneXr_darkMode")
        } else {
            let sut = sutBuild(weather: .mockThunderstorm)
            assertSnapshot(matching: sut, as: .image(on: .iPhone8), named: "iPhone8_lightMode")
            assertSnapshot(matching: sut, as: .image(on: .iPhoneXr), named: "iPhoneXr_lightMode")
        }
    }

    func test_weatherFog() throws {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            let sut = sutBuild(weather: .mockFog)
            assertSnapshot(matching: sut, as: .image(on: .iPhone8), named: "iPhone8_darkMode")
            assertSnapshot(matching: sut, as: .image(on: .iPhoneXr), named: "iPhoneXr_darkMode")
        } else {
            let sut = sutBuild(weather: .mockFog)
            assertSnapshot(matching: sut, as: .image(on: .iPhone8), named: "iPhone8_lightMode")
            assertSnapshot(matching: sut, as: .image(on: .iPhoneXr), named: "iPhoneXr_lightMode")
        }
    }

    func test_weatherSunny() throws {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            let sut = sutBuild(weather: .mockSunny)
            assertSnapshot(matching: sut, as: .image(on: .iPhone8), named: "iPhone8_darkMode")
            assertSnapshot(matching: sut, as: .image(on: .iPhoneXr), named: "iPhoneXr_darkMode")
        } else {
            let sut = sutBuild(weather: .mockSunny)
            assertSnapshot(matching: sut, as: .image(on: .iPhone8), named: "iPhone8_lightMode")
            assertSnapshot(matching: sut, as: .image(on: .iPhoneXr), named: "iPhoneXr_lightMode")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}

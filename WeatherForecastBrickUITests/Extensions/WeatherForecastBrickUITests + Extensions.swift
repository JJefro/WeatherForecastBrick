//
//  WeatherForecastBrickUITests + Extensions.swift
//  WeatherForecastBrickUITests
//
//  Created by Jevgenijs Jefrosinins on 07/11/2021.
//

import XCTest

extension XCUIApplication {

    var isOnMainView: Bool {
        return otherElements["mainView"].exists
    }
}

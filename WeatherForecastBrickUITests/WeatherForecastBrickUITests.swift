//
//  WeatherForecastBrickUITests.swift
//  WeatherForecastBrickUITests
//
//  Created by Jevgenijs Jefrosinins on 05/11/2021.
//

import XCTest

class WeatherForecastBrickUITests: XCTestCase {

    let accessibility = MainViewAccessibility()
    let label = TextLabels()

    var app: XCUIApplication!
    var brickImageView: XCUIElement!
    var temperatureLabel: XCUIElement!
    var infoImageView: XCUIElement!
    var infoTitle: XCUIElement!
    var weatherConditionLabel: XCUIElement!
    var areaLabel: XCUIElement!
    var searchButton: XCUIElement!
    var currentLocationButton: XCUIElement!

    var infoView: XCUIElement!
    var loadingView: XCUIElement!
    var searchView: XCUIElement!

    var infoViewTitleLabel: XCUIElement!
    var infoViewWetBrickLabel: XCUIElement!
    var infoViewDryBrickLabel: XCUIElement!
    var infoViewFogBrickLabel: XCUIElement!
    var infoViewGoneBrickLabel: XCUIElement!
    var infoViewHotBrickLabel: XCUIElement!
    var infoViewSnowBrickLabel: XCUIElement!
    var infoViewWindyBrickLabel: XCUIElement!
    var infoViewHideButton: XCUIElement!

    var searchViewHideButton: XCUIElement!
    var searchViewTextField: XCUIElement!
    var searchViewTitle: XCUIElement!

    override func setUpWithError() throws {
        continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.launch()

        self.brickImageView = app.images[accessibility.brickImageView]
        self.temperatureLabel = app.staticTexts[accessibility.temperatureLabel]
        self.infoImageView = app.images[accessibility.infoImageView]
        self.infoTitle = app.staticTexts[accessibility.infoTitle]
        self.weatherConditionLabel = app.staticTexts[accessibility.weatherConditionLabel]
        self.areaLabel = app.staticTexts[accessibility.areaLabel]
        self.searchButton = app.buttons[accessibility.searchButton]
        self.currentLocationButton = app.buttons[accessibility.currentLocationButton]

        self.infoView = app.otherElements[accessibility.infoView]
        self.loadingView = app.otherElements[accessibility.loadingView]
        self.searchView = app.otherElements[accessibility.searchView]

        self.infoViewTitleLabel = infoView.staticTexts[accessibility.infoViewTitleLabel]
        self.infoViewWetBrickLabel = infoView.staticTexts[accessibility.infoViewWetBrickLabel]
        self.infoViewDryBrickLabel = infoView.staticTexts[accessibility.infoViewDryBrickLabel]
        self.infoViewFogBrickLabel = infoView.staticTexts[accessibility.infoViewFogBrickLabel]
        self.infoViewGoneBrickLabel = infoView.staticTexts[accessibility.infoViewGoneBrickLabel]
        self.infoViewHotBrickLabel = infoView.staticTexts[accessibility.infoViewHotBrickLabel]
        self.infoViewSnowBrickLabel = infoView.staticTexts[accessibility.infoViewSnowBrickLabel]
        self.infoViewWindyBrickLabel = infoView.staticTexts[accessibility.infoViewWindyBrickLabel]
        self.infoViewHideButton = infoView.buttons[accessibility.infoViewHideButton]

        self.searchViewHideButton = searchView.buttons[accessibility.searchViewHideButton]
        self.searchViewTextField = searchView.textFields[accessibility.searchViewTextField]
        self.searchViewTitle = searchView.staticTexts[accessibility.searchViewTitle]
    }

    func testMainView_ThePresenceOfElements() throws {
        XCTAssertTrue(app.isOnMainView)
        XCTAssertTrue(brickImageView.exists)
        XCTAssertTrue(temperatureLabel.exists)
        XCTAssertTrue(infoImageView.exists)
        XCTAssertTrue(infoTitle.exists)
        XCTAssertTrue(weatherConditionLabel.exists)
        XCTAssertTrue(areaLabel.exists)
        XCTAssertTrue(searchButton.exists)
        XCTAssertTrue(currentLocationButton.exists)
    }

    func testInfoView_ThePresenceOfElements() throws {
        XCTAssertTrue(app.isOnMainView)
        infoImageView.tap()
        XCTAssertTrue(infoViewTitleLabel.exists)
        XCTAssertTrue(infoViewWetBrickLabel.exists)
        XCTAssertTrue(infoViewDryBrickLabel.exists)
        XCTAssertTrue(infoViewFogBrickLabel.exists)
        XCTAssertTrue(infoViewGoneBrickLabel.exists)
        XCTAssertTrue(infoViewHotBrickLabel.exists)
        XCTAssertTrue(infoViewSnowBrickLabel.exists)
        XCTAssertTrue(infoViewWindyBrickLabel.exists)
        XCTAssertTrue(infoViewHideButton.exists)
    }

    func testSearchView_ThePresenceOfElements() throws {
        searchButton.tap()
        XCTAssertTrue(searchViewTextField.exists)
        XCTAssertTrue(searchViewHideButton.exists)
    }

    func testInfoView_CheckBrickInformationLabels_EnglishLocalization() throws {
        XCTAssertTrue(app.isOnMainView)
        infoImageView.tap()
        XCTAssertEqual(infoViewTitleLabel.label, label.infoViewTitleLabel)
        XCTAssertEqual(infoViewWetBrickLabel.label, label.infoViewWetLabel)
        XCTAssertEqual(infoViewDryBrickLabel.label, label.infoViewDryLabel)
        XCTAssertEqual(infoViewFogBrickLabel.label, label.infoViewFogLabel)
        XCTAssertEqual(infoViewGoneBrickLabel.label, label.infoViewNoInternetLabel)
        XCTAssertEqual(infoViewHotBrickLabel.label, label.infoViewHotLabel)
        XCTAssertEqual(infoViewSnowBrickLabel.label, label.infoViewSnowLabel)
        XCTAssertEqual(infoViewWindyBrickLabel.label, label.infoViewWindLabel)
    }
    
    func testSearchView_TextField_EnglishLocalization() throws {
        searchButton.tap()
        searchViewTextField.tap()
        XCTAssertEqual(searchViewTextField.placeholderValue, label.searchViewTextfieldPlaceholder)
        XCTAssertEqual(searchViewTitle.label, label.searchViewTitle)
    }
}

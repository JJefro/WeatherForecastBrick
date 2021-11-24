//
//  MainViewController + AccessibilityIdentifiers.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 07/11/2021.
//

import Foundation

extension MainViewController {

    func createAccessibilityIdentifiers() {
        view.accessibilityIdentifier = MainViewAccessibilityID.mainView
        temperatureLabel.accessibilityIdentifier = MainViewAccessibilityID.temperatureLabel
        infoImageView.accessibilityIdentifier = MainViewAccessibilityID.infoImageView
        infoTitle.accessibilityIdentifier = MainViewAccessibilityID.infoTitle
        weatherConditionLabel.accessibilityIdentifier = MainViewAccessibilityID.weatherConditionLabel
        areaLabel.accessibilityIdentifier = MainViewAccessibilityID.areaLabel
        currentLocationButton.accessibilityIdentifier = MainViewAccessibilityID.currentLocationButton
        searchButton.accessibilityIdentifier = MainViewAccessibilityID.searchButton
        infoView.accessibilityIdentifier = MainViewAccessibilityID.infoView
        loadingView.accessibilityIdentifier = MainViewAccessibilityID.loadingView
    }
}

struct MainViewAccessibilityID {

    // MARK: - MainView Elements
    static let mainView = "mainView"

    static let brickImageView = "mainView_brickImageView"
    static let temperatureLabel = "mainView_temperatureLabel"
    static let infoImageView = "mainView_infoImageView"
    static let infoTitle = "mainView_infoTitle"
    static let weatherConditionLabel = "mainView_weatherConditionLabel"
    static let areaLabel = "mainView_areaLabel"
    static let searchButton = "mainView_searchButton"
    static let currentLocationButton = "mainView_currentLocationButton"
    static let infoView = "mainView_infoView"
    static let loadingView = "mainView_loadingView"

    // MARK: - InfoView Elements
    static let infoViewTitleLabel = "infoView_title"
    static let infoViewWetBrickLabel = "infoView_wetBrickLabel"
    static let infoViewDryBrickLabel = "infoView_dryBrickLabel"
    static let infoViewFogBrickLabel = "infoView_fogBrickLabel"
    static let infoViewGoneBrickLabel = "infoView_goneBrickLabel"
    static let infoViewHotBrickLabel = "infoView_hotBrickLabel"
    static let infoViewSnowBrickLabel = "infoView_snowBrickLabel"
    static let infoViewWindyBrickLabel = "infoView_windyBrickLabel"
    static let infoViewHideButton = "infoView_hideButton"

    // MARK: - SearchAlert Elements
    static let searchAlert  = "mainView_searchAlert"
    static let alertSearchButton = "mainView_searchAlert_searchButton"
    static let alertCancelButton = "mainView_searchAlert_cancelButton"
    static let searchAlertTextField = "mainView_searchAlert_textField"
}

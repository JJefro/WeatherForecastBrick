//
//  MainView + AccessibilityIdentifiers.swift
//  WeatherForecastBrickUITests
//
//  Created by Jevgenijs Jefrosinins on 07/11/2021.
//

import Foundation

struct MainViewAccessibility {

    let mainView = "mainView"

    let brickImageView        = "mainView_brickImageView"
    let temperatureLabel      = "mainView_temperatureLabel"
    let infoImageView         = "mainView_infoImageView"
    let infoTitle             = "mainView_infoTitle"
    let weatherConditionLabel = "mainView_weatherConditionLabel"
    let areaLabel             = "mainView_areaLabel"
    let searchButton          = "mainView_searchButton"
    let currentLocationButton = "mainView_currentLocationButton"
    
    let infoView    = "mainView_infoView"
    let loadingView = "mainView_loadingView"

    let infoViewTitleLabel      = "infoView_title"
    let infoViewWetBrickLabel   = "infoView_wetBrickLabel"
    let infoViewDryBrickLabel   = "infoView_dryBrickLabel"
    let infoViewFogBrickLabel   = "infoView_fogBrickLabel"
    let infoViewGoneBrickLabel  = "infoView_goneBrickLabel"
    let infoViewHotBrickLabel   = "infoView_hotBrickLabel"
    let infoViewSnowBrickLabel  = "infoView_snowBrickLabel"
    let infoViewWindyBrickLabel = "infoView_windyBrickLabel"
    let infoViewHideButton      = "infoView_hideButton"

    let searchAlert          = "mainView_searchAlert"
    let alertSearchButton    = "mainView_searchAlert_searchButton"
    let alertCancelButton    = "mainView_searchAlert_cancelButton"
    let searchAlertTextField = "mainView_searchAlert_textField"
}

struct TextLabels {
    let infoViewTitleLabel      = "INFO"
    let infoViewWetLabel        = "Brick is wet - raining"
    let infoViewDryLabel        = "Brick is dry - sunny"
    let infoViewFogLabel        = "Brick is hard to see - fog"
    let infoViewHotLabel        = "Brick with cracks - very hot"
    let infoViewSnowLabel       = "Brick with snow - snow"
    let infoViewWindLabel       = "Brick is swinging - windy"
    let infoViewNoInternetLabel = "Brick is gone - No Internet"
    let infoViewHideButtonTitle = "Hide"

    let searchViewTextfieldPlaceholder = "Type city name..."
    let searchViewTitle                = "City:"
}

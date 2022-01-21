//
//  WeatherManager.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation
import UIKit

protocol WeatherModelDelegate: AnyObject {
    func weatherModel(_ weatherModel: WeatherModelProtocol, willUpdate weather: WeatherEntity?)
    func weatherModel(_ weatherModel: WeatherModelProtocol, didUpdate weather: WeatherEntity)
    func weatherModel(_ weatherModel: WeatherModelProtocol, errorOccured error: Error)
    func weatherModel(_ weatherModel: WeatherModelProtocol, didCatchAnErrorFromServer error: WeatherError)
}

protocol WeatherModelProtocol {
    var delegate: WeatherModelDelegate? { get set }
    
    func updateWeatherAtCurrentLocation()
    func updateWeatherAt(city: String)
    func updateWeatherAtCity()
}

class WeatherModel: WeatherModelProtocol {

    weak var delegate: WeatherModelDelegate?
    private(set) var weather: WeatherEntity?

    private let locationService: LocationManagerProtocol
    private var networkService: NetworkManagerProtocol

    private var currentCity = String()
    
    init(locationService: LocationManagerProtocol, networkService: NetworkManagerProtocol) {
        self.locationService = locationService
        self.networkService = networkService

        self.networkService.delegate = self
    }
    
    func updateWeatherAtCurrentLocation() {
        delegate?.weatherModel(self, willUpdate: weather)
        locationService.requestLocation { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                self.delegate?.weatherModel(self, errorOccured: error)
            case let .success(location):
                self.networkService.getWeatherFrom(lat: location.lat, lon: location.lon) { weather in
                    self.transferWeatherToController(weather)
                }
            }
        }
    }
    
    func updateWeatherAtCity() {
        updateWeatherAt(city: currentCity)
    }
    
    func updateWeatherAt(city: String) {
        if !city.isEmpty {
            let text = NSMutableString(string: city) as CFMutableString
            CFStringTransform(text, nil, kCFStringTransformStripCombiningMarks, false)
            var city = (text as NSMutableString).copy() as! NSString
            city = city.replacingOccurrences(of: " ", with: "%20") as NSString

            delegate?.weatherModel(self, willUpdate: weather)
            networkService.getWeatherAt(city: city) { [self] weather in
                transferWeatherToController(weather)
            }
        } else {
            updateWeatherAtCity()
        }
    }

    private func transferWeatherToController(_ weather: Result<WeatherEntity, Error>) {
        switch weather {
        case let .success(weather):
            self.weather = weather
            self.currentCity = weather.cityName
            DispatchQueue.main.async { [self] in
                delegate?.weatherModel(self, didUpdate: weather)
            }
        case let .failure(error):
            DispatchQueue.main.async { [self] in
                delegate?.weatherModel(self, errorOccured: error)
            }
        }
    }
}

extension WeatherModel: NetworkManagerDelegate {
    func getErrorFromServer(_ error: WeatherError) {
        delegate?.weatherModel(self, didCatchAnErrorFromServer: error)
    }
}

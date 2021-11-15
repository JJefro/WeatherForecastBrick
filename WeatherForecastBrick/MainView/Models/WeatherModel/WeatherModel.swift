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
    func getErrorFromServer(error: WeatherError)
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
    
    private var network = NetworkManager()
    private var currentCity = String()
    
    init(locationService: LocationManagerProtocol) {
        self.locationService = locationService

        network.delegate = self
    }
    
    func updateWeatherAtCurrentLocation() {
        delegate?.weatherModel(self, willUpdate: weather)
        locationService.requestLocation { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                self.delegate?.weatherModel(self, errorOccured: error)
            case let .success(location):
                self.network.getWeatherFrom(lat: location.lat, lon: location.lon) { weather in
                    self.fetchWeather(weather)
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
            network.getWeatherAt(city: city) { [self] weather in
                fetchWeather(weather)
            }
        } else {
            updateWeatherAtCity()
        }
    }

    private func fetchWeather(_ weather: Result<WeatherEntity, Error>) {
        switch weather {
        case let .success(weather):
            self.delegate?.weatherModel(self, didUpdate: weather)
            self.currentCity = weather.cityName
        case let .failure(error):
            self.delegate?.weatherModel(self, errorOccured: error)
        }
    }
}

extension WeatherModel: NetworkManagerDelegate {
    func getErrorFromServer(error: WeatherError) {
        delegate?.getErrorFromServer(error: error)
    }
}

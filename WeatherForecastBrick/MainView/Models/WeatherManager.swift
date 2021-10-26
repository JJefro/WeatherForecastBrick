//
//  WeatherManager.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate: AnyObject {
    func updateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    weak var delegate: WeatherManagerDelegate?
    
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(Secrets.apiKey)&units=metric"

    func fetchWeatherByCityName(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeatherByLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = parseJSON(safeData) {
                        delegate?.updateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            let weatherID = decoderData.weather[0].id
            let city = decoderData.name
            let visibility = decoderData.visibility
            let countryCode = decoderData.sys.country
            let windSpeed = decoderData.wind.speed
            let temp = decoderData.main.temp
            let tempFeelsLike = decoderData.main.feels_like
            
            return WeatherModel(
                conditionID: weatherID,
                visibility: visibility,
                cityName: city,
                temperature: temp,
                countryCode: countryCode,
                windSpeed: windSpeed,
                temperatureFeelsLike: tempFeelsLike
            )
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

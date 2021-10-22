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
}

struct WeatherManager {

    weak var delegate: WeatherManagerDelegate?
    
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(Secrets.apiKey)&units=metric"

    func fetchData(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }

    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    print(error!.localizedDescription)
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
            let countryCode = decoderData.sys.country
            let wind = decoderData.wind.speed
            let temp = decoderData.main.temp
            let tempFeelsLike = decoderData.main.feels_like

            return WeatherModel(
                conditionID: weatherID, cityName: city, temperature: temp, countryCode: countryCode, wind: wind, temperatureFeelsLike: tempFeelsLike)
        } catch {
            print(error)
            return nil
        }
    }
}

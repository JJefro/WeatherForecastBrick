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
    func willFetchWeather()
    func getErrorFromServer(error: WeatherError)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    weak var delegate: WeatherManagerDelegate?
    
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(Secrets.apiKey)&units=metric"

    func fetchWeatherByCityName(cityName: String) {
        let text = NSMutableString(string: cityName) as CFMutableString
        CFStringTransform(text, nil, kCFStringTransformStripCombiningMarks, false)
        var city = (text as NSMutableString).copy() as! NSString
        city = city.replacingOccurrences(of: " ", with: "%20") as NSString

        let urlString = "\(weatherURL)&q=\(city)"
        delegate?.willFetchWeather() // On main thread
        performRequest(with: urlString)
    }
    
    func fetchWeatherByLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        delegate?.willFetchWeather() // On main thread
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    DispatchQueue.main.async {
                        delegate?.didFailWithError(error: error!)
                    }
                    return
                }
                if let safeData = data {
                    if let weather = parseJSON(safeData) {
                        DispatchQueue.main.async {
                            delegate?.updateWeather(self, weather: weather)
                        }
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
            return WeatherModel(data: decoderData)
        } catch {
            if let decoderErrorData = try? decoder.decode(WeatherError.self, from: weatherData) {
                DispatchQueue.main.async {
                    delegate?.getErrorFromServer(error: decoderErrorData)
                }
            }
        }
        return nil
    }
}

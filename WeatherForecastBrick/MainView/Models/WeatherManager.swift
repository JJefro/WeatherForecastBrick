//
//  WeatherManager.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation
import CoreLocation

struct WeatherManager {

    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=\(Secrets.apiKey)&units=metric"

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
                        print(weather)
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
            let name = decoderData.name
            let temp = decoderData.main.temp

            return WeatherModel(conditionID: weatherID, cityName: name, temperature: temp)
        } catch {
            print(error)
            return nil
        }
    }
}

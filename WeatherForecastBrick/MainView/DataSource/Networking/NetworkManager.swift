//
//  File.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 13/11/2021.
//

import Foundation

protocol NetworkManagerDelegate: AnyObject {
    func getErrorFromServer(error: WeatherError)
}

class NetworkManager {

    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(Secrets.apiKey)&units=metric"
    private var networkRequestCompletion: ((Result<WeatherEntity, Error>) -> Void)?
    weak var delegate: NetworkManagerDelegate?

    func getWeatherFrom(lat: Double, lon: Double, completion: @escaping (_ weather: Result<WeatherEntity, Error>) -> Void) {
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString) { weather in
            completion(weather)
        }
    }

    func getWeatherAt(city: NSString, completion: @escaping (_ weather: Result<WeatherEntity, Error>) -> Void) {
        let urlString = "\(weatherURL)&q=\(city)"
        performRequest(with: urlString) { weather in
            completion(weather)
        }
    }

    private func performRequest(with urlString: String, completion: @escaping (Result<WeatherEntity, Error>) -> Void) {
        networkRequestCompletion = completion
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    DispatchQueue.main.async { [self] in
                        networkRequestCompletion?(.failure(error!))
                    }
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        DispatchQueue.main.async { [self] in
                            networkRequestCompletion?(.success(weather))
                        }
                    }
                }
            }
            task.resume()
        }
    }

    private func parseJSON(_ weatherData: Data) -> WeatherEntity? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            return WeatherEntity(data: decoderData)
        } catch {
            if let decoderErrorData = try? decoder.decode(WeatherError.self, from: weatherData) {
                DispatchQueue.main.async { [self] in
                    delegate?.getErrorFromServer(error: decoderErrorData)
                }
            }
        }
        return nil
    }
}

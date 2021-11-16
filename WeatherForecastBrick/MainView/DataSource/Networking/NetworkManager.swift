//
//  File.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 13/11/2021.
//

import Foundation

typealias Completion = (Result<WeatherEntity, Error>) -> Void
typealias WeatherCompletion = ((_ weather: Result<WeatherEntity, Error>) -> Void)

protocol NetworkManagerProtocol {
    var weatherURL: String { get set }
    var networkRequestCompletion: (Completion)? { get set }
    var delegate: NetworkManagerDelegate? { get set }

    func getWeatherFrom(lat: Double, lon: Double, completion: @escaping WeatherCompletion)
    func getWeatherAt(city: NSString, completion: @escaping WeatherCompletion)
    func performRequest(with urlString: String, completion: @escaping Completion)
    func parseJSON(_ weatherData: Data) -> WeatherEntity?
}

protocol NetworkManagerDelegate: AnyObject {
    func getErrorFromServer(error: WeatherError)
}

class NetworkManager: NetworkManagerProtocol {

    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(Secrets.apiKey)&units=metric"
    var networkRequestCompletion: (Completion)?
    weak var delegate: NetworkManagerDelegate?

    func getWeatherFrom(lat: Double, lon: Double, completion: @escaping WeatherCompletion) {
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString) { weather in
            completion(weather)
        }
    }

    func getWeatherAt(city: NSString, completion: @escaping WeatherCompletion) {
        let urlString = "\(weatherURL)&q=\(city)"
        performRequest(with: urlString) { weather in
            completion(weather)
        }
    }

    func performRequest(with urlString: String, completion: @escaping Completion) {
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

    func parseJSON(_ weatherData: Data) -> WeatherEntity? {
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

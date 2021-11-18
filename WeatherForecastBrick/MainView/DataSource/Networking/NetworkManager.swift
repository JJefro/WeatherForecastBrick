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
    var delegate: NetworkManagerDelegate? { get set }

    func getWeatherFrom(lat: Double, lon: Double, completion: @escaping WeatherCompletion)
    func performRequest(with urlString: String, completion: @escaping Completion)
}

protocol NetworkManagerDelegate: AnyObject {
    func getErrorFromServer(_ error: WeatherError)
}

class NetworkManager: NetworkManagerProtocol {

    private var weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(Secrets.apiKey)&units=metric"
    private var networkRequestCompletion: (Completion)?
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

        guard let url = URL(string: urlString) else {return}
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {return}
            if let error = error {
                DispatchQueue.main.async { [self] in
                    networkRequestCompletion?(.failure(error))
                }
                return
            } else {
                if let safeData = data {
                    DispatchQueue.main.async { [self] in
                        checkStatusCode(response.statusCode, data: safeData)
                    }
                } else {return}
            }
        }
        task.resume()
    }

    private func checkStatusCode(_ statusCode: Int, data: Data) {
        switch statusCode {
        case 200..<300:
            if let weather = parseJSON(data) {
                networkRequestCompletion?(.success(weather))
            }
        case 400...:
            if let errorData = catchError(data) {
                delegate?.getErrorFromServer(errorData)
                return
            }
        default: return
        }
    }

    private func parseJSON(_ weatherData: Data) -> WeatherEntity? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            return WeatherEntity(data: decoderData)
        } catch {
            networkRequestCompletion?(.failure(error))
            return nil
        }
    }

    private func catchError(_ errorData: Data) -> WeatherError? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decoderData = try decoder.decode(WeatherError.self, from: errorData)
            return WeatherError(cod: decoderData.cod, message: decoderData.message)
        } catch {
            networkRequestCompletion?(.failure(error))
            return nil
        }
    }
}

//
//  Network.swift
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
    func getWeatherAt(city: NSString, completion: @escaping WeatherCompletion)
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
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(.failure(NetworkError.badURL))
            }
            return
        }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.badServerResponse))
                }
                return
            }
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            } else {
                if let safeData = data {
                    if response.statusCode / 100 == 2 {
                        if let weather = self.parseJSON(safeData) {
                            DispatchQueue.main.async {
                                completion(.success(weather))
                            }
                        }
                    } else if response.statusCode / 100 == 4 {
                        if let errorData = self.catchError(safeData) {
                            DispatchQueue.main.async { [self] in
                                delegate?.getErrorFromServer(errorData)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(.failure(NetworkError.badStatusCode))
                        }
                        return
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.noDataError))
                    }
                    return
                }
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherEntity? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            return WeatherEntity(data: decoderData)
        } catch {
            DispatchQueue.main.async { [self] in
                networkRequestCompletion?(.failure(error))
            }
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
            DispatchQueue.main.async { [self] in
                networkRequestCompletion?(.failure(error))
            }
            return nil
        }
    }
}

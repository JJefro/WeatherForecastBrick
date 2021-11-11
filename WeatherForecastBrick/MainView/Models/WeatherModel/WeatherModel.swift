//
//  WeatherManager.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation

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

    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(Secrets.apiKey)&units=metric"
    private var currentCity = String()

    init(locationService: LocationManagerProtocol) {
        self.locationService = locationService
    }

    func updateWeatherAtCurrentLocation() {
        delegate?.weatherModel(self, willUpdate: weather)
        locationService.requestLocation { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                self.delegate?.weatherModel(self, errorOccured: error)
            case let .success(location):
                let urlString = "\(self.weatherURL)&lat=\(location.lat)&lon=\(location.lon)"
                self.performRequest(with: urlString)
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

            let urlString = "\(weatherURL)&q=\(city)"
            delegate?.weatherModel(self, willUpdate: weather)
            performRequest(with: urlString)
        } else {
            updateWeatherAtCity()
        }
    }
    
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    DispatchQueue.main.async { [self] in
                        delegate?.weatherModel(self, errorOccured: error!)
                    }
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        DispatchQueue.main.async { [self] in
                            delegate?.weatherModel(self, didUpdate: weather)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherEntity? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            currentCity = decoderData.name
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

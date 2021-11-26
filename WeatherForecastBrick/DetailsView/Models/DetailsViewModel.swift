//
//  DetailsViewModel.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 26/11/2021.
//

import Foundation

protocol DetailsViewModelDelegate: AnyObject {
    func transferData(data: [WeatherEntity])
}

class DetailsViewModel {

    weak var delegate: DetailsViewModelDelegate?

    private let locationService = LocationManager()
    private var networkService = NetworkManager()

    var cities = ["Riga", "London", "Berlin", "Paris"]
    var weatherEntities: [WeatherEntity] = []

    func getWeatherDataForEachCity(completion: @escaping () -> Void) {
        for city in cities {
            networkService.getWeatherAt(city: city as NSString) { result in
                switch result {
                case let .success(weather):
                    self.weatherEntities.append(weather)
                    if self.cities.count == self.weatherEntities.count {
                        self.transferWeatherData()
                        completion()
                    }
                case let .failure(error):
                    self.cities.removeAll(where: {$0 == city})
                    print(error)
                }
            }
        }
    }

    private func transferWeatherData() {
        DispatchQueue.main.async { [self] in
            delegate?.transferData(data: weatherEntities)
        }
    }
}

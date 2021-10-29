//
//  Secrets.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation
import UIKit

struct Secrets {

    static var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "Secrets", ofType: "plist") else {
                fatalError("Couldn't find file 'Secrets.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "Weather API key") as? String else {
                fatalError("Couldn't find key 'Weather API key' in 'Secrets.plist'.")
            }
            if value == "YOUR_API_KEY" {
                fatalError("Register for a developer account and get an API key")
            }
            return value
        }
    }
}

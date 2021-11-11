//
//  SearchViewDelegate.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 03/11/2021.
//

import Foundation
import UIKit

extension MainViewController: SearchViewDelegate {

    func getSearchViewText(text: String) {
        model.updateWeatherAt(city: text)
        searchView.isHidden = true
        animateSearchView()
        if text.isEmpty {
            showAlert()
        }
    }

    private func showAlert() {
        let alert = UIAlertController(title: "", message: "Weather update", preferredStyle: UIAlertController.Style.alert)
        alert.showAlert()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}

//
//  UITextFieldDelegate.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 24/10/2021.
//

import Foundation
import UIKit

protocol SearchViewDelegate: AnyObject {
    func getSearchViewText(text: String)
}

extension SearchView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.isSelected = true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.isSelected = false
        guard let text = textField.text else {return}
        delegate?.getSearchViewText(text: text)
        textField.text?.removeAll()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

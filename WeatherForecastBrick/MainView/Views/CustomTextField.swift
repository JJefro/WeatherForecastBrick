//
//  CustomTextField.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 24/10/2021.
//

import Foundation
import UIKit

class CustomTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        isSelected = false
        configureCustomTextField()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isSelected: Bool {
        didSet {
            self.layer.borderColor = !isSelected ? R.color.mainView.passiveBorderColor()?.cgColor : R.color.mainView.activeBorderColor()?.cgColor
        }
    }

    private func configureCustomTextField() {
        self.borderStyle = .roundedRect
        layer.borderWidth = 1
        layer.cornerRadius = 10
        self.font = R.font.sfProDisplayRegular(size: 17)
        self.textColor = R.color.mainView.textColor()
        self.backgroundColor = .clear
    }
}

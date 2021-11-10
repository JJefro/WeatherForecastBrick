//
//  Brick.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 05/11/2021.
//

import Foundation
import UIKit

class BrickView: UIImageView {

    var isSwinging = Bool()

    override func layoutSubviews() {
        super.layoutSubviews()
        removeAnimation()

        self.accessibilityIdentifier = MainViewAccessibilityID.brickImageView
        self.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.layer.position = CGPoint(x: UIScreen.main.bounds.width/2, y: 227.5)
    }

    private func removeAnimation() {
        if isSwinging {
            self.transform = .identity
            self.layer.removeAllAnimations()
        }
    }
}

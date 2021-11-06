//
//  Brick.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 05/11/2021.
//

import Foundation
import UIKit

class BrickView: UIImageView {

    override func layoutSubviews() {
         super.layoutSubviews()
        self.setAnchorPoint(CGPoint(x: 0.5, y: 0.5))
        self.layer.position = CGPoint(x: UIScreen.main.bounds.width/2, y: 227.5)
     }
}

//
//  SetAnchorPoint.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 28/10/2021.
//

import UIKit

extension UIView {

    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)

        var position = layer.position
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
}
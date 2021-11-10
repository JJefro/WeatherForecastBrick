//
//  BrickStateModel.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 02/11/2021.
//

import Foundation
import UIKit

class BrickModel {
    
    private var windForce = Double()
    var initialBrickHeight = CGFloat()
    var brickView = BrickView()

    var panDelta: CGFloat = 0 {
        didSet {
            if panDelta > 0, state != .brickWentUp {
                state = .brickCalmedDown
            }
        }
    }
    
    var state: BrickState = .brickCalmedDown {
        didSet {
            updateBrick()
        }
    }
    
    private func updateBrick() {
        switch state {
        case .brickWentUp, .brickCalmedDown:
            brickView.isSwinging = false
            brickView.transform = .identity
            brickView.layer.removeAllAnimations()
            brickView.setAnchorPoint(CGPoint(x: 0.5, y: 0.5))
        case .brickAnimatable:
            brickView.isSwinging = true
            brickView.setAnchorPoint(CGPoint(x: 0.5, y: 0))
        }
    }
    
    func changeBrickCondition(weather: WeatherEntity) -> UIImage? {
        windForce = weather.windSpeed
        brickView.layer.zPosition = weather.condition != .fog ? 1 : -1
        brickView.alpha = 1
        if weather.condition == .sunny, weather.temperatureFeelsLike > 29 {
            return R.image.mainView.brick.cracksBrick()
        } else {
            switch weather.condition {
            case .thunderstorm: return R.image.mainView.brick.wetBrick()
            case .raining:      return R.image.mainView.brick.wetBrick()
            case .drizzle:      return R.image.mainView.brick.wetBrick()
            case .tornado:      return R.image.mainView.brick.normalBrick()
            case .clouds:       return R.image.mainView.brick.normalBrick()
            case .sunny:        return R.image.mainView.brick.normalBrick()
            case .snow:         return R.image.mainView.brick.snowBrick()
            case .fog:
                brickView.alpha = getBrickOpacity(weather.visibility)
            default: break
            }
        }
        return R.image.mainView.brick.normalBrick()
    }
    
    private func getBrickOpacity(_ visibility: Int) -> CGFloat {
        switch visibility {
        // Weather visibility | Brick opacity
        case 20_000...:        return 1
        case 10_000...19_999:  return 0.9
        case 4_000...9_999:    return 0.7
        case 2_000...3_999:    return 0.6
        case 1_000...1_999:    return 0.4
        case 500...999:        return 0.3
        case 200...499:        return 0.2
        case ...199:           return 0.1
        default:               return 0.05
        }
    }
    
    func setBrickAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [self] in
            switch windForce {
            case 30...:
                animateBrick(with: 4)
            case 21...29:
                animateBrick(with: 6)
            case 15...20:
                animateBrick(with: 9)
            case 11...14:
                animateBrick(with: 13)
            case 6...10:
                animateBrick(with: 15)
            default: state = .brickCalmedDown
            }
        }
    }
    
    private func animateBrick(with number: CGFloat) {
        let numberOfFrames: Double = 2
        let frameDuration = Double(1 / numberOfFrames)
        
        state = .brickAnimatable
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction]) { [self] in
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: frameDuration) {
                brickView.transform = CGAffineTransform(rotationAngle: .pi / number)
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: frameDuration * 2) {
                brickView.transform = CGAffineTransform(rotationAngle: -(.pi / number))
            }
        }
    }
}

//
//  BrickStateModel.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 02/11/2021.
//

import Foundation
import UIKit

protocol BrickModelDelegate: AnyObject {
    func getBrickState(_ state: BrickState)
}

class BrickModel {

    weak var delegate: BrickModelDelegate?

    private var windForce = Double()

    var panDelta: CGFloat = 0 {
        didSet {
            if panDelta > 0, brickState != .brickWentUp {
                brickState = .brickCalmedDown
            }
        }
    }

    var brickState: BrickState = .brickCalmedDown {
        didSet {
            delegate?.getBrickState(brickState)
        }
    }

    func changeBrickCondition(_ brickView: UIImageView, weather: WeatherModel) -> UIImage? {
        windForce = weather.windSpeed
        if weather.condition == .sunny, weather.tempFeelsLike > 29 {
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
                brickView.layer.zPosition = -1
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

    func setBrickAnimation(_ brickView: UIImageView) {
        switch windForce {
        case 30...:
            animateBrick(brickView, with: 6)
        case 21...29:
            animateBrick(brickView, with: 8)
        case 15...20:
            animateBrick(brickView, with: 11)
        case 11...14:
            animateBrick(brickView, with: 14)
        case 3...10:
            animateBrick(brickView, with: 18)
        default: break
        }
    }

    private func animateBrick(_ brickView: UIImageView, with number: CGFloat) {
        let numberOfFrames: Double = 2
        let frameDuration = Double(1 / numberOfFrames)

        brickState = .brickAnimatable

        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction]) {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: frameDuration) {
                brickView.transform = CGAffineTransform(rotationAngle: .pi / number)
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: frameDuration * 2) {
                brickView.transform = CGAffineTransform(rotationAngle: -(.pi / number))
            }
        }
    }
}

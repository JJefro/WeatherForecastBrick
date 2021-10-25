//
//  presentAlert.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 25/10/2021.
//

import Foundation
import UIKit

extension UIAlertController {

    func presentAlert() {
        let keywindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        if var viewController = keywindow?.rootViewController {
            while let presentedViewController = viewController.presentedViewController {
                viewController = presentedViewController
            }
            viewController.present(self, animated: true, completion: nil)
        }
    }
}

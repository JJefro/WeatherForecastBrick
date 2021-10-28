//
//  presentAlert.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 25/10/2021.
//

import Foundation
import UIKit

extension UIAlertController {

    func showAlert() {
        let keywindow = UIApplication.shared.connectedScenes.filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .first(where: { $0.isKeyWindow })
        if var viewController = keywindow?.rootViewController {
            while let presentedViewController = viewController.presentedViewController {
                viewController = presentedViewController
            }
            viewController.present(self, animated: true, completion: nil)
        }
    }
}

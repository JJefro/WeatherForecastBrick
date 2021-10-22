//
//  LoadingView.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

class WeatherLoadingView: UIView {

    private var activityIndicator = NVActivityIndicatorView(
        frame: .zero,
        type: .ballScaleMultiple,
        color: UITraitCollection.current.userInterfaceStyle == .dark ? .white : .darkGray,
        padding: 0
    )

    private let blurView: UIVisualEffectView = {
        var blur = UIBlurEffect()
        let lightBlur = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let darkBlur = UIBlurEffect(style: .systemUltraThinMaterialDark)
        blur = UITraitCollection.current.userInterfaceStyle == .dark ? darkBlur : lightBlur
        let blurView = UIVisualEffectView(effect: blur)
        return blurView
    }()

    override var isHidden: Bool {
        didSet {
            if isHidden {
                activityIndicator.stopAnimating()
            } else {
                activityIndicator.startAnimating()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLoadingView()
        isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLoadingView() {
        self.addSubview(blurView)
        blurView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        makeActivityIndicatorConstraints()
    }

    private func makeActivityIndicatorConstraints() {
        self.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.size.equalTo(60)
        }
    }
}

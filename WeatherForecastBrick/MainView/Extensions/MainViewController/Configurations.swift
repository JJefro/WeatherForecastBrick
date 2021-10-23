//
//  LoadingView.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation
import SnapKit

extension MainViewController {

    func configure() {
        makeLoadingViewConstraints()
        bind()
    }
    
    private func bind() {
        locationManager.delegate = self
        weatherManager.delegate = self
    }

    private func makeLoadingViewConstraints() {
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

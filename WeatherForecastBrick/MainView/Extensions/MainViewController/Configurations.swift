//
//  LoadingView.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation
import SnapKit
import CoreLocation

extension MainViewController {

    func configure() {
        bind()
        makeLoadingViewConstraints()
        makeSearchViewConstraints()
    }

    private func bind() {
        weatherManager.delegate = self
        searchView.delegate = self
        locationManager.weatherManager = weatherManager
    }

    private func makeSearchViewConstraints() {
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(100)
            make.top.equalTo(infoView.snp.bottom)
        }
    }

    private func makeLoadingViewConstraints() {
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

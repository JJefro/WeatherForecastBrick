//
//  LoadingView.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import Foundation
import SnapKit
import CoreLocation
import UIKit

extension MainViewController {

    // MARK: - MainViewController Configuration
    func configure() {
        bind()
        makeLoadingViewConstraints()
        makeSearchViewConstraints()
        makeOpenedInfoViewConstraints()
        brickImage.layer.zPosition = 1
    }

    private func bind() {
        weatherManager.delegate = self
        searchView.delegate = self
        locationManager.weatherManager = weatherManager
    }

    // MARK: - Opened Info View Constraints
    private func makeOpenedInfoViewConstraints() {
        view.addSubview(openedInfoView)
        openedInfoView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(277)
            make.height.equalTo(372)
        }
    }

    // MARK: - Search View Constraints
    private func makeSearchViewConstraints() {
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(100)
            make.top.equalTo(infoView.snp.bottom)
        }
    }

    // MARK: - Loading View Constraints
    private func makeLoadingViewConstraints() {
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

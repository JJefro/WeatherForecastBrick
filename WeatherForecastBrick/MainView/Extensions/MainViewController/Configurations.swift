//
//  LoadingView.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 22/10/2021.
//

import SnapKit
import CoreLocation
import UIKit

extension MainViewController {

    // MARK: - MainViewController Configurations
    func configure() {
        bind()
        makeLoadingViewConstraints()
        makeSearchViewConstraints()
        makeInfoViewConstraints()
        brickImageView.layer.zPosition = 1
        infoTitle.text = R.string.localizable.infoView_title()
    }

    private func bind() {
        weatherManager.delegate = self
        searchView.delegate = self
        locationManager.delegate = self
    }

    // MARK: - Info View Constraints
    private func makeInfoViewConstraints() {
        view.addSubview(infoView)
        infoView.snp.makeConstraints { make in
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
            make.height.equalTo(150)
            make.top.equalTo(info.snp.bottom)
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

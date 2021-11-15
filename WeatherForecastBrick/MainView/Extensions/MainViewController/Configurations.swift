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
        makeInfoViewConstraints()
        makeSearchViewConstraints()
        createAccessibilityIdentifiers()
        
        brickImageView.layer.zPosition = 1
        infoTitle.text = R.string.localizable.infoView_title()
        
        addTargetsForElements()
    }

    private func bind() {
        model.delegate = self
        searchView.delegate = self
    }

    // MARK: - Add Targets For UI Elements
    private func addTargetsForElements() {
        infoView.infoHideButton.addTarget(self, action: #selector(infoViewHideButtonTapped(_:)), for: .touchUpInside)
        searchView.hideButton.addTarget(self, action: #selector(searchViewHideButtonTapped(_:)), for: .touchUpInside)
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
            make.top.equalTo(view.snp.bottom)
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

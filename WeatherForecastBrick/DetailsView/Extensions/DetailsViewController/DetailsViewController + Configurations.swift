//
//  DetailsViewController + Configurations.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 25/11/2021.
//

import Foundation
import SnapKit
import UIKit

extension DetailsViewController {

    func configure() {
        makeSearchTextFieldConstraints()
        configureCollectionView()
        makeLoadingViewConstraints()
        bind()
    }

    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = layout.minimumLineSpacing
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        collectionView.backgroundColor = view.backgroundColor
        collectionView.register(
            DetailsCollectionViewCell.self,
            forCellWithReuseIdentifier: DetailsCollectionViewCell.identifier)
        makeCollectionViewConstraints()
    }

    private func bind() {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        model.delegate = self
    }

    private func makeCollectionViewConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(100)
            make.right.left.bottom.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }

    private func makeLoadingViewConstraints() {
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func makeSearchTextFieldConstraints() {
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(20)
            make.top.equalToSuperview()
        }
    }
}

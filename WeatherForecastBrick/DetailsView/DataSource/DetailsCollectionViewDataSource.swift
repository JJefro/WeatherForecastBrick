//
//  DetailsCollectionViewDataSource.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 25/11/2021.
//

import UIKit

class DetailsCollectionViewDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var objects: [WeatherEntity] = []

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height / 8
        return CGSize(width: collectionView.frame.width - 40, height: height)
    }

    // MARK: - UICollectionView Data Source Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        objects.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCollectionViewCell.identifier, for: indexPath) as! DetailsCollectionViewCell
        let weatherData = objects[indexPath.row]
        cell.set(object: weatherData)
        cell.layer.cornerRadius = 25
        cell.backgroundColor = R.color.detailsView.cellBackground()
        return cell
    }
}

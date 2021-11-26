//
//  DetailsViewController.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 25/11/2021.
//

import UIKit

class DetailsViewController: UIViewController {

    var collectionView: UICollectionView!
    var searchTextField = UITextField()
    var loadingView = LoadingView()

    var dataSource = DetailsCollectionViewDataSource()
    var model = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.backgroundColor = R.color.detailsView.backgroundColor()
        title = R.string.localizable.detailsView_title()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        updateData()
    }

    func updateData() {
        loadingView.isHidden = false
        model.getWeatherDataForEachCity(completion: { [self] in
            collectionView.reloadData()
            loadingView.isHidden = true
        })
    }
}

extension DetailsViewController: DetailsViewModelDelegate {
    func transferData(data: [WeatherEntity]) {
        dataSource.objects = data
        DispatchQueue.main.async { [self] in
            collectionView.reloadData()
        }
    }
}

//
//  ViewController.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 21/10/2021.
//

import UIKit
import CoreLocation
import NVActivityIndicatorView

class MainViewController: UIViewController {

    @IBOutlet weak var brickImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var infoView: UIImageView!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var currentLocationButton: UIButton!

    var loadingView = LoadingView()
    var searchView = SearchView()
    
    var weatherManager = WeatherManager()
    var locationManager = LocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    @IBAction func getCurrentLocation(_ sender: UIButton) {
        loadingView.isHidden = false
        locationManager.locationManager.requestLocation()
    }

    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchView.isHidden.toggle()
        animateSearchView()
    }

    func animateSearchView() {
        UIView.animate(withDuration: 1, delay: 0, options: []) { [self] in
            if searchView.isHidden == false {
                brickImage.transform = CGAffineTransform(translationX: 0, y: -300)
                temperatureLabel.transform = CGAffineTransform(translationX: -300, y: 0)
                weatherCondition.transform = CGAffineTransform(translationX: -300, y: 0)
                searchView.transform = CGAffineTransform(translationX: 0, y: -view.frame.size.height / 2)
            } else {
                brickImage.transform = .identity
                temperatureLabel.transform = .identity
                weatherCondition.transform = .identity
                searchView.transform = .identity
            }
        }
    }
}

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
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var currentLocationButton: UIButton!
    
    var loadingView = WeatherLoadingView()

    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
    }

    @IBAction func searchButtonTapped(_ sender: UIButton) {
        brickImage.image = R.image.mainView.brick.wetBrick()
    }
    
    @IBAction func currentLocationButtonTapped(_ sender: UIButton) {
        loadingView.isHidden = false
        locationManager.requestLocation()
    }
}

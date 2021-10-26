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
    @IBOutlet weak var infoViewTitle: UILabel!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var currentLocationButton: UIButton!

    var openedInfoView = OpenedInfoView()

    var loadingView = LoadingView()
    var searchView = SearchView()
    
    var weatherManager = WeatherManager()
    var locationManager = LocationManager()
    var currentCity = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        openedInfoView.button.addTarget(self, action: #selector(infoViewButtonTapped(_:)), for: .touchUpInside)
        addTapGesture(view: infoView)
        addDownSwipeGesture(view: brickImage)
    }

    @IBAction func getCurrentLocation(_ sender: UIButton) {
        loadingView.isHidden = false
        locationManager.locationManager.requestLocation()
    }

    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchView.isHidden.toggle()
        animateSearchView()
    }

    private func addTapGesture(view: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap(_:)))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }

    private func addDownSwipeGesture(view: UIView) {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleDownSwipe(_:)))
        swipe.direction = .down
        view.addGestureRecognizer(swipe)
    }

    @objc func handleDownSwipe(_ sender: UISwipeGestureRecognizer) {
        loadingView.isHidden = false
        weatherManager.fetchWeatherByCityName(cityName: currentCity)
    }

    @objc func handleSingleTap(_ sender: UITapGestureRecognizer) {
        openedInfoView.isHidden = false
        animateInfoView()
    }

    @objc func infoViewButtonTapped(_ sender: UIButton) {
        openedInfoView.isHidden = true
        animateInfoView()
    }
}

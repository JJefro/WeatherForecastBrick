//
//  ViewController.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 21/10/2021.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {

    @IBOutlet weak var brickImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var info: UIImageView!
    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var searchButton: CardButton!
    @IBOutlet weak var currentLocationButton: CardButton!

    var infoView = InfoView()

    var loadingView = LoadingView()
    var searchView = SearchView()

    var weatherManager = WeatherManager()
    var locationManager = LocationManager()

    var currentCity = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        infoView.button.addTarget(self, action: #selector(infoViewButtonTapped(_:)), for: .touchUpInside)
        addTapGesture(view: info)
        addPanGesture(view: brickImage)
    }

    @IBAction func getCurrentLocation(_ sender: UIButton) {
        loadingView.isHidden = false
        brickImage.isHidden = true
        locationManager.requestLocation()
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

    private func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(pan)
    }

    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        UIView.animate(withDuration: 0.5) { [self] in
            brickImage.transform = CGAffineTransform(translationX: 0, y: -10)
            if sender.state == .ended {
                loadingView.isHidden = false
                brickImage.transform = CGAffineTransform(translationX: 0, y: 0)
                weatherManager.fetchWeatherByCityName(cityName: currentCity)
            }
        } completion: { _ in
            self.brickImage.transform = .identity
        }
    }

    @objc func handleSingleTap(_ sender: UITapGestureRecognizer) {
        infoView.isHidden = false
        animateInfoView()
    }

    @objc func infoViewButtonTapped(_ sender: UIButton) {
        infoView.isHidden = true
        animateInfoView()
    }
}

// MARK: - LocationManager Delegate
extension MainViewController: LocationManagerDelegate {

    func getLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        weatherManager.fetchWeatherByLocation(latitude: latitude, longitude: longitude)
    }
}

// MARK: - SearchView Delegate
extension MainViewController: SearchViewDelegate {

    func getSearchViewText(text: String) {
        weatherManager.fetchWeatherByCityName(cityName: text)
        searchView.isHidden = true
        animateSearchView()
    }
}

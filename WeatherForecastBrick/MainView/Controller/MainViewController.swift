//
//  ViewController.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 21/10/2021.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {

    @IBOutlet weak var brickImageView: UIImageView!
    @IBOutlet weak var brickHeight: NSLayoutConstraint!
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

    var brickModel = BrickModel()

    var weatherManager = WeatherManager()
    var locationManager = LocationManager()

    var currentCity = String()
    private var initialBrickHeight = CGFloat()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        infoView.button.addTarget(self, action: #selector(infoViewButtonTapped(_:)), for: .touchUpInside)
        addTapGesture(view: info)
        addPanGesture(view: brickImageView)
        initialBrickHeight = brickHeight.constant
    }

    @IBAction func getCurrentLocation(_ sender: UIButton) {
        brickModel.brickState = .brickCalmedDown
        locationManager.requestLocation()
    }

    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchView.isHidden.toggle()
        animateSearchView()
    }

    private func addTapGesture(view: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap(_:)))
        view.addGestureRecognizer(tap)
    }

    private func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(pan)
    }

    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            let translation = sender.translation(in: view).y
            if initialBrickHeight < brickHeight.constant + translation {
                brickHeight.constant += translation
                brickModel.panDelta += translation
                sender.setTranslation(.zero, in: view)
            }
        case .cancelled, .ended, .failed:
            if brickModel.panDelta > 60, brickModel.brickState != .brickWentUp {
                weatherManager.fetchWeatherByCityName(cityName: currentCity)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                brickModel.setBrickAnimation(brickImageView)
            }
            brickHeight.constant -= brickModel.panDelta
            brickModel.panDelta = 0
        default: break
        }
    }

    @objc func handleSingleTap(_ sender: UITapGestureRecognizer) {
        infoView.isHidden = false
        animateInfoView()
    }

    @objc func infoViewButtonTapped(_ sender: UIButton) {
        infoView.isHidden = true
        weatherManager.fetchWeatherByCityName(cityName: currentCity)
        animateInfoView()
    }
}

// MARK: - BrickModel Delegate
extension MainViewController: BrickModelDelegate {
    func getBrickState(_ state: BrickState) {
        switch state {
        case .brickWentUp:
            brickImageView.transform = .identity
            brickImageView.layer.removeAllAnimations()
            brickImageView.setAnchorPoint(CGPoint(x: 0.5, y: 0.5))

            currentLocationButton.isEnabled = false

        case .brickAnimatable:
            brickImageView.setAnchorPoint(CGPoint(x: 0.5, y: 0))
            
        case .brickCalmedDown:я
            brickImageView.transform = .identity
            brickImageView.layer.removeAllAnimations()
            brickImageView.setAnchorPoint(CGPoint(x: 0.5, y: 0.5))

            currentLocationButton.isEnabled = true
        }
    }
}

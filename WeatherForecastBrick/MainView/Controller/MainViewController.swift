//
//  ViewController.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 21/10/2021.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet weak var brickImageView: BrickView!
    @IBOutlet weak var brickHeight: NSLayoutConstraint!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var searchButton: CardButton!
    @IBOutlet weak var currentLocationButton: CardButton!
    
    var infoView = InfoView()
    var loadingView = LoadingView()
    var searchView = SearchView()
    
    var brickModel = BrickModel()
    
    var model: WeatherModelProtocol = WeatherModel(locationService: LocationManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        addTapGesture(view: infoImageView)
        addPanGesture(view: brickImageView)

        brickModel.brickView = brickImageView
        brickModel.initialBrickHeight = brickHeight.constant
        
        model.updateWeatherAtCurrentLocation()
    }

    @IBAction func getCurrentLocation(_ sender: UIButton) {
        model.updateWeatherAtCurrentLocation()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchView.isHidden.toggle()
        currentLocationButton.isEnabled.toggle()
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
        case .changed, .began, .possible:
            let translation = sender.translation(in: view).y
            if brickModel.initialBrickHeight < brickHeight.constant + translation {
                brickHeight.constant += translation
                brickModel.panDelta += translation
                sender.setTranslation(.zero, in: view)
            }
        case .cancelled, .ended, .failed:
            if brickModel.panDelta > 80, brickModel.state != .brickWentUp {
                model.updateWeatherAtCity()
            } else if brickModel.state != .brickWentUp {
                brickModel.setBrickAnimation()
            }
            brickHeight.constant -= brickModel.panDelta
            brickModel.panDelta = 0
        @unknown default: break
        }
    }
    
    @objc func handleSingleTap(_ sender: UITapGestureRecognizer) {
        infoView.isHidden = false
        animateInfoView()
    }
    
    @objc func infoViewHideButtonTapped(_ sender: UIButton) {
        infoView.isHidden = true
        model.updateWeatherAtCity()
        animateInfoView()
    }

    @objc func searchViewHideButtonTapped(_ sender: UIButton) {
        searchView.isHidden = true
        currentLocationButton.isEnabled = true
        model.updateWeatherAtCity()
        animateSearchView()
    }
}

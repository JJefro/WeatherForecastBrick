//
//  ViewController.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 21/10/2021.
//

import UIKit

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
    @IBOutlet weak var detailsButton: UIBarButtonItem!
    
    var infoView = InfoView()
    var loadingView = LoadingView()
    
    var brickModel = BrickModel()
    var model: WeatherModelProtocol = WeatherModel(
        locationService: LocationManager(),
        networkService: NetworkManager())

    var isSearchShown = false {
        didSet {
            if isSearchShown {
                animateSearchView()
                showSearchAlert()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        addTapGesture(view: infoImageView)
        addPanGesture(view: brickImageView)

        brickModel.brickView = brickImageView
        brickModel.initialBrickHeight = brickHeight.constant
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        model.updateWeatherAtCurrentLocation()
    }

    @IBAction func getCurrentLocation(_ sender: UIButton) {
        model.updateWeatherAtCurrentLocation()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        isSearchShown = true
    }

    func showSearchAlert() {
        let alert = UIAlertController(title: R.string.localizable.searchView_title(), message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = R.string.localizable.searchView_TextFieldPlaceholder()
            textField.returnKeyType = .search
            textField.accessibilityIdentifier = MainViewAccessibilityID.searchAlertTextField
        }
        let searchButton = UIAlertAction(title: R.string.localizable.searchView_searchButton(), style: .default) { [self] _ in
            guard let text = alert.textFields?.first?.text else {return}
            model.updateWeatherAt(city: text)
            isSearchShown = false
            animateSearchView()
        }
        let cancelButton = UIAlertAction(title: R.string.localizable.searchView_cancelButton(), style: .cancel) { [self] _ in
            model.updateWeatherAtCity()
            isSearchShown = false
            animateSearchView()
        }
        alert.view.accessibilityIdentifier = MainViewAccessibilityID.searchAlert
        searchButton.accessibilityIdentifier = MainViewAccessibilityID.alertSearchButton
        cancelButton.accessibilityIdentifier = MainViewAccessibilityID.alertCancelButton
        alert.addAction(searchButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
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

    func showError(withTitle title: String?, withMessage message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.errorAlert_actionButton(), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

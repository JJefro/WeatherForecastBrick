//
//  ViewController.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 21/10/2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var brickImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var infoView: UIImageView!

    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

//
//  DetailsTableViewCell.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 26/11/2021.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

class DetailsCollectionViewCell: UICollectionViewCell {

    static let identifier = "DetailsCollectionViewCell"

    private var cityName = UILabel()
    private var temperatureLabel = UILabel()
    private var weatherConditionLabel = UILabel()

    var spinner = NVActivityIndicatorView(
            frame: .zero,
            type: .pacman,
            color: UITraitCollection.current.userInterfaceStyle == .dark ? .white : .black,
            padding: 0
        )

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cityName)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(weatherConditionLabel)
        contentView.addSubview(spinner)
        contentView.clipsToBounds = true
        configureCityNameLabel()
        configureTemperatureLabel()
        configureWeatherConditionLabel()
        setSpinnerConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func set(object: WeatherEntity) {
        cityName.text = object.cityName
        temperatureLabel.text = object.tempString
        weatherConditionLabel.text = object.condition.condition
    }

    // MARK: - CityName Label Configurations
    private func configureCityNameLabel() {
        cityName.textColor = R.color.mainView.textColor()
        cityName.font = R.font.sfProDisplayBold(size: 22)
        cityName.numberOfLines = 0
        setCityNameLabelConstraints()
    }

    private func setCityNameLabelConstraints() {
        cityName.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(20)
            make.top.equalTo(contentView).inset(20)
        }
    }

    // MARK: - Temperature Label Configurations
    private func configureTemperatureLabel() {
        temperatureLabel.textColor = R.color.mainView.textColor()
        temperatureLabel.font = R.font.sfProDisplayBold(size: 30)
        temperatureLabel.numberOfLines = 0
        setTemperatureLabelConstraints()
    }

    private func setTemperatureLabelConstraints() {
        temperatureLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
        }
    }

    // MARK: - WeatherConditionLabel Configurations
    private func configureWeatherConditionLabel() {
        weatherConditionLabel.textColor = R.color.mainView.textColor()
        weatherConditionLabel.font = R.font.sfProDisplayBold(size: 22)
        weatherConditionLabel.numberOfLines = 0
        setWeatherConditionLabelConstraints()
    }

    private func setWeatherConditionLabelConstraints() {
        weatherConditionLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(20)
            make.bottom.equalTo(contentView).inset(20)
        }
    }

    // MARK: - Spinner Constraints
    private func setSpinnerConstraints() {
        spinner.snp.makeConstraints { make in
            make.center.equalTo(contentView)
            make.height.width.equalTo(30)
        }
    }
}

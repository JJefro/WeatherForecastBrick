//
//  OpenedInfoView.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 26/10/2021.
//

import Foundation
import UIKit
import SnapKit

class OpenedInfoView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        configureOpenedInfoView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureOpenedInfoView() {
        self.backgroundColor = R.color.mainView.infoView.infoViewShadow()
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 15
        makeLabelsConstraints()
        makeButtonConstraints()
        makeBackgroundViewConstraints()
    }

    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Hide", for: .normal)
        button.setTitleColor(R.color.mainView.infoView.buttonBorders(), for: .normal)
        button.titleLabel?.font = R.font.sfProDisplaySemibold(size: 15)
        button.layer.borderColor = R.color.mainView.infoView.buttonBorders()?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.backgroundColor = .clear
        return button
    }()

    private func makeButtonConstraints() {
        self.addSubview(button)
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(24)
            make.height.equalTo(31)
            make.width.equalTo(115)
            make.centerX.equalToSuperview()
        }
    }

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.mainView.infoView.infoViewBackgroundColor()
        view.layer.cornerRadius = 15
        return view
    }()

    private func makeBackgroundViewConstraints() {
        self.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.bottom.left.equalTo(self)
            make.right.equalTo(self).offset(-8)
        }
        self.sendSubviewToBack(backgroundView)
    }

    private let title: UILabel = {
        let title = UILabel()
        title.font = R.font.sfProDisplaySemibold(size: 15)
        title.textColor = .black
        title.textAlignment = .left
        title.text = "INFO"
        return title
    }()

    private let wetBrickLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProDisplaySemibold(size: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Brick is wet - raining"
        return label
    }()

    private let dryBrickLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProDisplaySemibold(size: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Brick is dry - sunny"
        return label
    }()

    private let fogBrickLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProDisplaySemibold(size: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Brick is hard to see - fog"
        return label
    }()

    private let hotBrickLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProDisplaySemibold(size: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Brick with cracks - very hot"
        return label
    }()

    private let snowBrickLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProDisplaySemibold(size: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Brick with snow - snow"
        return label
    }()

    private let windyBrickLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProDisplaySemibold(size: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Brick is swinging - windy"
        return label
    }()

    private let goneBrickLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProDisplaySemibold(size: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Brick is gone - No Internet"
        return label
    }()

    private func makeLabelsConstraints() {
        self.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        self.addSubview(wetBrickLabel)
        wetBrickLabel.snp.makeConstraints { make in
            make.top.equalTo(title).inset(40)
            make.left.equalToSuperview().inset(30)
        }
        self.addSubview(dryBrickLabel)
        dryBrickLabel.snp.makeConstraints { make in
            make.top.equalTo(wetBrickLabel).inset(35)
            make.left.equalTo(wetBrickLabel)
        }
        self.addSubview(fogBrickLabel)
        fogBrickLabel.snp.makeConstraints { make in
            make.top.equalTo(dryBrickLabel).inset(35)
            make.left.equalTo(wetBrickLabel)
        }
        self.addSubview(hotBrickLabel)
        hotBrickLabel.snp.makeConstraints { make in
            make.top.equalTo(fogBrickLabel).inset(35)
            make.left.equalTo(wetBrickLabel)
        }

        self.addSubview(snowBrickLabel)
        snowBrickLabel.snp.makeConstraints { make in
            make.top.equalTo(hotBrickLabel).inset(35)
            make.left.equalTo(wetBrickLabel)
        }
        self.addSubview(windyBrickLabel)
        windyBrickLabel.snp.makeConstraints { make in
            make.top.equalTo(snowBrickLabel).inset(35)
            make.left.equalTo(wetBrickLabel)
        }
        self.addSubview(goneBrickLabel)
        goneBrickLabel.snp.makeConstraints { make in
            make.top.equalTo(windyBrickLabel).inset(35)
            make.left.equalTo(wetBrickLabel)
        }
    }
}

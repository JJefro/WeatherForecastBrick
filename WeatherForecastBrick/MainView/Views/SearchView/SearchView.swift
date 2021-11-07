//
//  SearchView.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 24/10/2021.
//

import UIKit
import SnapKit

class SearchView: UIView {

    weak var delegate: SearchViewDelegate?

    var searchTextField = CustomTextField()
    private var buttonView = UIView()
    private let cornerRadius: CGFloat = 25

    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        configureSearchView()
        searchTextField.accessibilityIdentifier = MainViewAccessibilityID.searchViewTextField
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let hideButton: CardButton = {
        var button = CardButton()
        button.setTitle(R.string.localizable.searchView_hideButton(), for: .normal)
        button.backgroundColor = .gray
        button.titleLabel?.font = R.font.sfProDisplaySemibold(size: 15)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.accessibilityIdentifier = MainViewAccessibilityID.searchViewHideButton
        return button
    }()

    private func configureSearchView() {
        configureBlurView()
        configureButtonView()
        configureTextField()
        configureTextLabel()
        bind()
    }

    private func bind() {
        searchTextField.delegate = self
    }

    // MARK: - BlurView Configuration
    private func configureBlurView() {
        let blurView: UIVisualEffectView = {
            var blur = UIBlurEffect()
            let lightBlur = UIBlurEffect(style: .systemMaterialLight)
            let darkBlur = UIBlurEffect(style: .systemMaterialDark)
            blur = UITraitCollection.current.userInterfaceStyle == .dark ? darkBlur : lightBlur
            let blurView = UIVisualEffectView(effect: blur)
            blurView.clipsToBounds = true
            blurView.layer.cornerRadius = cornerRadius
            return blurView
        }()

        self.addSubview(blurView)
        blurView.snp.makeConstraints { make in
            make.right.left.top.equalTo(self)
            make.bottom.equalTo(self).offset(-50)
        }
    }

    // MARK: - CustomTextField Configuration
    private func configureTextField() {
        searchTextField.placeholder = R.string.localizable.searchView_TextFieldPlaceholder()
        searchTextField.returnKeyType = .search
        searchTextField.keyboardType = .alphabet
        createTextFieldConstraints()
    }

    private func createTextFieldConstraints() {
        self.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(self).inset(45)
            make.left.right.equalTo(self).inset(20)
        }
    }

    // MARK: - TextField Configuration
    private func configureTextLabel() {
        let label = UILabel()
        label.text = R.string.localizable.searchView_title()
        label.font = R.font.sfProDisplayRegular(size: 17)
        label.textColor = R.color.mainView.textColor()
        label.accessibilityIdentifier = MainViewAccessibilityID.searchViewTitle

        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(searchTextField)
            make.bottom.equalTo(searchTextField.snp.top).offset(-6)
        }
    }

    // MARK: ButtonView and SearchButton Configurations
    private func configureButtonView() {
        buttonView.backgroundColor = .darkGray
        buttonView.layer.cornerRadius = cornerRadius
        makeButtonViewConstraints()
    }

    private func makeButtonViewConstraints() {
        self.addSubview(hideButton)
        hideButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(20)
            make.width.equalTo(100)
            make.bottom.equalTo(self.snp.bottom).inset(25)
        }
        self.addSubview(buttonView)
        buttonView.snp.makeConstraints { make in
            make.right.left.equalTo(self)
            make.height.equalTo(100)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).inset(20)
        }
        self.sendSubviewToBack(buttonView)
    }
}

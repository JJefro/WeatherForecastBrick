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

    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        configureSearchView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSearchView() {
        configureBlurView()
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
            blurView.layer.cornerRadius = 25
            return blurView
        }()

        self.addSubview(blurView)
        blurView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }

    // MARK: - CustomTextField Configuration
    private func configureTextField() {
        searchTextField.placeholder = R.string.localizable.searchInfo_placeholder()
        searchTextField.returnKeyType = .search
        searchTextField.keyboardType = .alphabet
        createTextFieldConstraints()
    }

    private func createTextFieldConstraints() {
        self.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).inset(20)
            make.left.right.equalTo(self).inset(20)
        }
    }

    // MARK: - TextField Configuration
    private func configureTextLabel() {
        let label = UILabel()
        label.text = R.string.localizable.searchInfo_title()
        label.font = R.font.sfProDisplayRegular(size: 17)
        label.textColor = R.color.mainView.textColor()

        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(searchTextField)
            make.bottom.equalTo(searchTextField.snp.top).offset(-6)
        }
    }
}

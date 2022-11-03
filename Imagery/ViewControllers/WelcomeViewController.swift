//
//  WelcomeViewController.swift
//  Imagery
//
//  Created by Вадим Сосновский on 21.10.2022.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    private let backgroundImageView = UIImageView(image: UIImage(named: "welcomeWallpaper"), contentMode: .scaleAspectFill)
    private let welcomeLabel = UILabel(font: .helveticaNeueBold30(), textColor: .mainWhite())
    private let additionLabel = UILabel(font: .helveticaNeueLight24(), textColor: .mainWhite())
    private let loginButton = UIButton(title: "LOGIN OR REGISTER")
    
    private var labelsStackView = UIStackView()
    private var bottomStackView = UIStackView()
    
    var viewModel: WelcomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
}

// MARK: - Setup IBActions
extension WelcomeViewController {
    @objc private func loginButtonTapped() {
        viewModel.loginButtonTapped()
    }
}

// MARK: - Setup Views
extension WelcomeViewController {
    private func setupViews() {
        
        labelsStackView = UIStackView(arrangedSubviews: [welcomeLabel,
                                                         additionLabel],
                                      axis: .vertical,
                                      spacing: 20,
                                      distribution: .fillEqually,
                                      alignment: .fill)
        
        bottomStackView = UIStackView(arrangedSubviews: [labelsStackView,
                                                         loginButton],
                                      axis: .vertical,
                                      spacing: 70,
                                      distribution: .fill,
                                      alignment: .fill)
        
        welcomeLabel.text = "Welcome to Imagery"
        additionLabel.text = "Beautiful Free Images"
        
        view.addSubview(backgroundImageView)
        view.addSubview(bottomStackView)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Setup Constraints
extension WelcomeViewController {
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-100)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
    }
}

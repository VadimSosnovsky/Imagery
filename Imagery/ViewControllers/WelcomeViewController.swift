//
//  WelcomeViewController.swift
//  Imagery
//
//  Created by Вадим Сосновский on 21.10.2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let backgroundImageView = UIImageView(image: UIImage(named: "wallpaper"), contentMode: .scaleAspectFill)
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
        customizeElements()
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
    }
    
    private func customizeElements() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Setup Constraints
extension WelcomeViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

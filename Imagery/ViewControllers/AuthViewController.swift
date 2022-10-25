//
//  AuthViewController.swift
//  Imagery
//
//  Created by Вадим Сосновский on 21.10.2022.
//

import UIKit

class AuthViewController: UIViewController {
    
    private let backgroundImageView = UIImageView(image: UIImage(named: "authWallpaper"), contentMode: .scaleAspectFill)
    
    private let loginLabel = UILabel(font: .helveticaNeueBold30(), textColor: .mainWhite())
    
    private let signUpButton = UIButton(title: "Sign up")
    private let signInButton = UIButton(title: "Sign in")
    
    private let emailTextField = AuthTextField(placeholder: "Enter email",
                                               leftImageName: "user",
                                               isButtonNeed: false)
    
    private let passwordTextField = AuthTextField(placeholder: "Enter password",
                                                  leftImageName: "key",
                                                  isButtonNeed: true)
    
    private var textFiledsStackView = UIStackView()
    private var buttonsStackView = UIStackView()
    
    private var textFields = [UITextField]()
    var viewModel: AuthViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        viewModel.delegate = self
        setupViews()
        customizeElements()
        setupConstraints()
        
        viewModel.viewDidLoad()
        viewModel.onUpdate = { [weak self] in
            self?.loginLabel.text = "Registration complete"
        }
        
        textFields = [emailTextField, passwordTextField]
    }
}

// MARK: - AuthViewModelDelegate
extension AuthViewController: AlertViewModelDelegate {
    func showAlert() {
        errorAlertController(title: "Wrong login or password")
    }
}

// MARK: - Setup IBActions
extension AuthViewController {
    
    @objc private func showAndHideCharactersTapped() {
        viewModel.showAndHideCharactersTapped(passwordTextField: passwordTextField)
    }
    
    @objc private func signInButtonTapped() {
        viewModel.signInButtonTapped(textFields: textFields)
    }
    
    @objc private func signUpButtonTapped() {
        viewModel.signUpButtonTapped()
    }
}

// MARK: - Setup Views
extension AuthViewController {
    private func setupViews() {
        
        textFiledsStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField],
                                          axis: .vertical,
                                          spacing: 10,
                                          distribution: .fillProportionally,
                                          alignment: .fill)
        
        buttonsStackView = UIStackView(arrangedSubviews: [signInButton, signUpButton],
                                       axis: .horizontal,
                                       spacing: 10,
                                       distribution: .fillEqually,
                                       alignment: .fill)
        
        loginLabel.text = "Login"
        
        view.addSubview(backgroundImageView)
        view.addSubview(loginLabel)
        view.addSubview(textFiledsStackView)
        view.addSubview(buttonsStackView)
    }
    
    private func customizeElements() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        textFiledsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        if let button = passwordTextField.rightView as? UIButton {
            button.addTarget(self, action: #selector(showAndHideCharactersTapped), for: .touchUpInside)
        }
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        
        passwordTextField.isSecureTextEntry = true
    }
}

// MARK: - Setup Constraints
extension AuthViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLabel.bottomAnchor.constraint(equalTo: textFiledsStackView.topAnchor, constant: -36)
        ])
        
        NSLayoutConstraint.activate([
            textFiledsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFiledsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textFiledsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            textFiledsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            textFiledsStackView.heightAnchor.constraint(equalToConstant: 96)
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: textFiledsStackView.bottomAnchor, constant: 36),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}


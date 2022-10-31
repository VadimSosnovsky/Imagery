//
//  AuthViewController.swift
//  Imagery
//
//  Created by Вадим Сосновский on 21.10.2022.
//

import UIKit
import SnapKit

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
        setupConstraints()
        
        viewModel.viewDidLoad()
        viewModel.onUpdate = { [weak self] in
            self?.loginLabel.text = "Registration complete"
        }
        
        textFields = [emailTextField, passwordTextField]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = nil
        passwordTextField.text = nil
    }
    
    deinit {
        print("auth deinit")
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
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(textFiledsStackView.snp.top).offset(-36)
        }
        
        textFiledsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(96)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(textFiledsStackView.snp.bottom).offset(36)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(48)
        }
    }
}


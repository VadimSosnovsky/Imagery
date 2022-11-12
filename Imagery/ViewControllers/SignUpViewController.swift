//
//  SignUpViewController.swift
//  Imagery
//
//  Created by Вадим Сосновский on 24.10.2022.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    private let backgroundImageView = UIImageView(image: UIImage(named: "signUpWallpaper"), contentMode: .scaleAspectFill)
    private let loginLabel = UILabel(font: .helveticaNeueBold30(), textColor: .mainWhite())
    private let emailTextField = AuthTextField(placeholder: "Email")
    private let emailValidLabel = UILabel(font: .helveticaNeueLight24(), textColor: .mainWhite())
    private let passwordTextField = AuthTextField(placeholder: "Password")
    private let passwordValidLabel = UILabel(font: .helveticaNeueLight24(), textColor: .mainWhite())
    
    private let signUpButton = UIButton(title: "Sign up")
    private var elementsStackView = UIStackView()
    
    let emailValidType: String.ValidTypes = .email
    let passwordValidType: String.ValidTypes = .password
    
    private var textFields = [UITextField]()
    var viewModel: SignUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
        setupDelegates()
        
        textFields = [emailTextField, passwordTextField]
    }
    
    override func viewWillLayoutSubviews() {
        emailValidLabel.textAlignment = .left
        passwordValidLabel.textAlignment = .left
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
}

// MARK: - SignUpViewModelDelegate
extension SignUpViewController: AlertViewModelDelegate {
    func showAlert() {
        errorAlertController(title: "The email address is already in use by another account")
    }
}

// MARK: - Setup Views
extension SignUpViewController {
    private func setupViews() {
        
        elementsStackView = UIStackView(arrangedSubviews: [emailTextField,
                                                           emailValidLabel,
                                                           passwordTextField,
                                                           passwordValidLabel],
                                        axis: .vertical,
                                        spacing: 0,
                                        distribution: .fillEqually,
                                        alignment: .fill)
        
        loginLabel.text = "Registration"
        
        view.addSubview(backgroundImageView)
        view.addSubview(loginLabel)
        view.addSubview(elementsStackView)
        view.addSubview(signUpButton)
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
}


// MARK: - Setup IBActions
extension SignUpViewController {
    @objc private func signUpButtonTapped() {
        viewModel.signUpButtonTapped(textFields: textFields)
    }
}

// MARK: - Setup Constraints
extension SignUpViewController {
    private func setupConstraints() {
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(elementsStackView.snp.top).offset(-36)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        elementsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(elementsStackView.snp.bottom).offset(36)
            make.height.equalTo(48)
            make.width.equalTo(300)
        }
    }
}

// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case emailTextField:
            setupTextField(textField: emailTextField,
                           label: emailValidLabel,
                           validtype: emailValidType,
                           validMessage: "Email is valid",
                           wrongMessage: "Email is not valid",
                           string: string,
                           range: range)
        case passwordTextField:
            setupTextField(textField: passwordTextField,
                           label: passwordValidLabel,
                           validtype: passwordValidType,
                           validMessage: "Password is valid",
                           wrongMessage: "Password is not valid",
                           string: string,
                           range: range)
        default:
            break
        }
        
        return false
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    private func setupDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        viewModel.delegate = self
    }
}

//
//  SignUpViewController.swift
//  Imagery
//
//  Created by Вадим Сосновский on 24.10.2022.
//

import UIKit

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
        customizeElements()
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
    
    deinit {
        print("SignUpViewController deinit")
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
    }
    
    private func customizeElements() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        elementsStackView.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
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
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLabel.bottomAnchor.constraint(equalTo: elementsStackView.topAnchor, constant: -36)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            elementsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            elementsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            elementsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            elementsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: elementsStackView.bottomAnchor, constant: 36),
            signUpButton.heightAnchor.constraint(equalToConstant: 48),
            signUpButton.widthAnchor.constraint(equalToConstant: 300)
        ])
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

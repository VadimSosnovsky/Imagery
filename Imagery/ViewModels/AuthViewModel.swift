//
//  AuthViewModel.swift
//  Imagery
//
//  Created by Вадим Сосновский on 21.10.2022.
//

import UIKit
import FirebaseAuth

final class AuthViewModel {
    
    weak var delegate: AlertViewModelDelegate?
    var authService = AuthService.shared
    var coordinator: AuthCoordinator?
    var onUpdate = {}
    
    func viewDidLoad() {
        reload()
    }
    
    func reload() {
       onUpdate()
    }
    
    func showAndHideCharactersTapped(passwordTextField: UITextField) {
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    func signInButtonTapped(textFields: [UITextField]) {
        
        guard let email = textFields.first?.text else { return }
        guard let password = textFields.last?.text else { return }
        
        authService.signIn(withEmail: email, password: password, authViewModel: self)
    }
    
    func signUpButtonTapped() {
        coordinator?.startSignUpScene()
    }
}

//
//  AuthViewModel.swift
//  Imagery
//
//  Created by Вадим Сосновский on 21.10.2022.
//

import UIKit

final class AuthViewModel {
    
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
    
    func signInButtonTapped() {
        
    }
    
    func signUpButtonTapped() {
        coordinator?.startSignUpScene()
    }
}

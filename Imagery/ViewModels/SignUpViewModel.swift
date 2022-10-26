//
//  SignUpViewModel.swift
//  Imagery
//
//  Created by Вадим Сосновский on 24.10.2022.
//

import UIKit
import FirebaseAuth

final class SignUpViewModel {
    
    var coordinator: SignUpCoordinator?
    var authService = AuthService.shared
    weak var delegate: AlertViewModelDelegate?
    
    func signUpButtonTapped(textFields: [UITextField]) {
        guard let email = textFields.first?.text else { return }
        guard let password = textFields.last?.text else { return }
        
        authService.signUp(withEmail: email, password: password, signUpViewModel: self)
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
}

//
//  SignUpViewModel.swift
//  Imagery
//
//  Created by Вадим Сосновский on 24.10.2022.
//

import UIKit
import FirebaseAuth

protocol SignUpViewModelDelegate: AnyObject {
    func showAlert()
}

final class SignUpViewModel {
    
    var coordinator: SignUpCoordinator?
    weak var delegate: SignUpViewModelDelegate?
    
    func signUpButtonTapped(textFields: [UITextField]) {
        guard let email = textFields.first?.text else { return }
        guard let password = textFields.last?.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (_, error) in
            if let error = error {
                print(error.localizedDescription)
                self?.delegate?.showAlert()
            } else {
                self?.coordinator?.didFinishSignUp()
            }
        }
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
}

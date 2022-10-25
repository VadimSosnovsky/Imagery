//
//  AuthService.swift
//  Imagery
//
//  Created by Вадим Сосновский on 25.10.2022.
//

import UIKit
import FirebaseAuth

final class AuthService {
    static let shared = AuthService()
    private init() {}
    
    func signIn(withEmail email: String, password: String, authViewModel: AuthViewModel) {
        
//        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (_, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                authViewModel.delegate?.showAlert()
//            } else {
//                authViewModel.coordinator?.didFinishSignUp()
//            }
//        }
    }
}

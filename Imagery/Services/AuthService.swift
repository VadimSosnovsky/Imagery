//
//  AuthService.swift
//  Imagery
//
//  Created by Вадим Сосновский on 25.10.2022.
//

import UIKit
import FirebaseAuth

final class AuthService: AuthServiceProtocol {
    
    static let shared = AuthService()
    private init() {}
    
    func signIn(withEmail email: String, password: String, authViewModel: AuthViewModel) {
//        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                authViewModel.delegate?.showAlert()
//            } else {
//                authViewModel.coordinator?.startImageryScene()
//            }
//        }
        authViewModel.coordinator?.startImageryScene()
    }
    
    func signUp(withEmail email: String, password: String, signUpViewModel: SignUpViewModel) {
        Auth.auth().createUser(withEmail: email, password: password) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
                signUpViewModel.delegate?.showAlert()
            } else {
                signUpViewModel.coordinator?.didFinishSignUp()
            }
        }
    }
}

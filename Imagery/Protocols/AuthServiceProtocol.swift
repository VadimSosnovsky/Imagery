//
//  AuthServiceProtocol.swift
//  Imagery
//
//  Created by Вадим Сосновский on 26.10.2022.
//

import UIKit

protocol AuthServiceProtocol {
    func signIn(withEmail email: String, password: String, authViewModel: AuthViewModel)
    func signUp(withEmail email: String, password: String, signUpViewModel: SignUpViewModel)
}

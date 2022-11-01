//
//  FavoriteViewModel.swift
//  Imagery
//
//  Created by Вадим Сосновский on 25.10.2022.
//

import Foundation
import FirebaseAuth

final class FavoriteViewModel {
    
    var coordinator: FavoriteCoordinator?
    
    func logoutButtonTapped() {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            coordinator?.logout()
        } catch let signOutError {
            print(signOutError)
        }
    }
}

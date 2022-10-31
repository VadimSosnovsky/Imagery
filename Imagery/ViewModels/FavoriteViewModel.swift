//
//  FavoriteViewModel.swift
//  Imagery
//
//  Created by Вадим Сосновский on 25.10.2022.
//

import Foundation
import FirebaseAuth

final class FavoriteViewModel {
    
    var coordinator: ImageryTabBarCoordinator?
    
    func logoutButtonTapped() {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            coordinator?.didFinishTabBar()
        } catch let signOutError {
            print(signOutError)
        }
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
}

//
//  WelcomeViewModel.swift
//  Imagery
//
//  Created by Вадим Сосновский on 21.10.2022.
//

import Foundation

final class WelcomeViewModel {
    
    var coordinator: WelcomeCoordinator?
    
    func loginButtonTapped() {
        coordinator?.startAuthScene()
    }
}


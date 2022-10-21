//
//  AuthCoordinator.swift
//  Imagery
//
//  Created by Вадим Сосновский on 21.10.2022.
//

import UIKit

final class AuthCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    func start() {
        let authViewController = AuthViewController()
        let authViewModel = AuthViewModel()
        authViewModel.coordinator = self
        authViewController.viewModel = authViewModel
    }
}


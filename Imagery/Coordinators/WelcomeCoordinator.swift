//
//  WelcomeCoordinator.swift
//  Imagery
//
//  Created by Вадим Сосновский on 21.10.2022.
//

import UIKit

final class WelcomeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let welcomeViewController = WelcomeViewController()
        let welcomeViewModel = WelcomeViewModel()
        welcomeViewModel.coordinator = self
        welcomeViewController.viewModel = welcomeViewModel
        navigationController.setViewControllers([welcomeViewController], animated: true)
    }
}


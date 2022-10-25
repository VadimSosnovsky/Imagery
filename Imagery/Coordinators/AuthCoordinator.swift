//
//  AuthCoordinator.swift
//  Imagery
//
//  Created by Вадим Сосновский on 21.10.2022.
//

import UIKit

final class AuthCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var onUpdateAuthScene = {}
    
    private let navigationController: UINavigationController
    var parentCoordinator: WelcomeCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let authViewController = AuthViewController()
        let authViewModel = AuthViewModel()
        authViewModel.coordinator = self
        onUpdateAuthScene = authViewModel.reload
        authViewController.viewModel = authViewModel
        navigationController.setViewControllers([authViewController], animated: true)
    }
    
    func startSignUpScene() {
        let signUpCoordinator = SignUpCoordinator(navigationController: navigationController)
        signUpCoordinator.parentCoordinator = self
        childCoordinators.append(signUpCoordinator)
        signUpCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}

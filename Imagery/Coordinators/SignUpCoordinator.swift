//
//  SignUpCoordinator.swift
//  Imagery
//
//  Created by Вадим Сосновский on 24.10.2022.
//

import UIKit

final class SignUpCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    weak var parentCoordinator: AuthCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let signUpViewController = SignUpViewController()
        let signUpViewModel = SignUpViewModel()
        signUpViewModel.coordinator = self
        signUpViewController.viewModel = signUpViewModel
        signUpViewController.modalPresentationStyle = .fullScreen
        navigationController.present(signUpViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishSignUp() {
        parentCoordinator?.onUpdateAuthScene()
        navigationController.dismiss(animated: true, completion: nil)
    }
}

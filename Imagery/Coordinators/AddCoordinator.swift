//
//  AddCoordinator.swift
//  Imagery
//
//  Created by Вадим Сосновский on 31.10.2022.
//

import UIKit

final class AddCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: SearchCoordinator?
    
    private let navigationController: UINavigationController
    private let selectedImage: UIImage
    
    init(navigationController: UINavigationController, selectedImage: UIImage) {
        self.navigationController = navigationController
        self.selectedImage = selectedImage
    }
    
    func start() {
        print("AddCoordinator Start")
        let addViewController = AddViewController()
        let addViewModel = AddViewModel(selectedImage: selectedImage)
        addViewModel.coordinator = self
        addViewController.viewModel = addViewModel
        addViewController.modalPresentationStyle = .fullScreen
        navigationController.present(addViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishAddScene() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
//    deinit {
//        print("AddCoordinator deinit")
//    }
}

//
//  RemoveCoordinator.swift
//  Imagery
//
//  Created by Вадим Сосновский on 09.11.2022.
//

import UIKit

final class RemoveCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: FavoriteCoordinator?
    
    private let navigationController: UINavigationController
    private let selectedImage: UIImage
    
    init(navigationController: UINavigationController, selectedImage: UIImage) {
        self.navigationController = navigationController
        self.selectedImage = selectedImage
    }
    
    func start() {
        let removeViewController = RemoveViewController()
        let removeViewModel = RemoveViewModel(selectedImage: selectedImage)
        removeViewModel.coordinator = self
        removeViewController.viewModel = removeViewModel
        removeViewController.modalPresentationStyle = .fullScreen
        navigationController.present(removeViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishRemoveScene() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}

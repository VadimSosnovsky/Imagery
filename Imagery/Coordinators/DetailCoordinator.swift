//
//  DetailCoordinator.swift
//  Imagery
//
//  Created by Вадим Сосновский on 31.10.2022.
//

import UIKit

final class DetailCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: SearchCoordinator?
    
    private let navigationController: UINavigationController
    private let selectedImage: UIImage
    
    init(navigationController: UINavigationController, selectedImage: UIImage) {
        self.navigationController = navigationController
        self.selectedImage = selectedImage
    }
    
    func start() {
        let detailViewController = DetailViewController()
        let detailViewModel = DetailViewModel(selectedImage: selectedImage)
        detailViewModel.coordinator = self
        detailViewController.viewModel = detailViewModel
        detailViewController.modalPresentationStyle = .fullScreen
        navigationController.present(detailViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishDetailScene() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}

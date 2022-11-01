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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let detailViewController = DetailViewController()
        let detailViewModel = DetailViewModel()
        detailViewModel.coordinator = self
        detailViewController.viewModel = detailViewModel
        navigationController.setViewControllers([detailViewController], animated: true)
        detailViewController.modalPresentationStyle = .fullScreen
        navigationController.present(detailViewController, animated: true)
    }
}

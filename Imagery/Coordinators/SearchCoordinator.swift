//
//  SearchCoordinator.swift
//  Imagery
//
//  Created by Вадим Сосновский on 31.10.2022.
//

import UIKit

final class SearchCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: ImageryTabBarCoordinator?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = SearchViewController()
        let searchViewModel = SearchViewModel()
        searchViewModel.coordinator = self
        searchViewController.viewModel = searchViewModel
        searchViewController.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(searchViewController, animated: true)
    }
    
    func startAddScene(withImage image: UIImage) {
        let addCoordinator = AddCoordinator(navigationController: navigationController, selectedImage: image)
        addCoordinator.parentCoordinator = self
        childCoordinators.append(addCoordinator)
        addCoordinator.start()
    }
}

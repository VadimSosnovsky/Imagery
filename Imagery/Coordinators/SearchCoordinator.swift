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
        print("SearchCoordinator Start")
        let searchViewController = SearchViewController()
        let searchViewModel = SearchViewModel()
        searchViewModel.coordinator = self
        searchViewController.viewModel = searchViewModel
        searchViewController.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(searchViewController, animated: true)
    }
    
    func startDetailScene(withImage image: UIImage) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, selectedImage: image)
        detailCoordinator.parentCoordinator = self
        childCoordinators.append(detailCoordinator)
        detailCoordinator.start()
    }

    deinit {
        print("SearchCoordinator Deinit")
    }
}

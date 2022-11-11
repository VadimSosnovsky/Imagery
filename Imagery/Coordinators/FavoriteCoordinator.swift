//
//  FavoriteCoordinator.swift
//  Imagery
//
//  Created by Вадим Сосновский on 31.10.2022.
//

import UIKit

final class FavoriteCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: ImageryTabBarCoordinator?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("FavoriteCoordinator Start")
        let favoriteViewController = FavoriteViewController()
        let favoriteViewModel = FavoriteViewModel()
        favoriteViewModel.coordinator = self
        favoriteViewController.viewModel = favoriteViewModel
        favoriteViewController.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(favoriteViewController, animated: true)
    }
    
    func startRemoveScene(withImage image: UIImage) {
        let removeCoordinator = RemoveCoordinator(navigationController: navigationController, selectedImage: image)
        removeCoordinator.parentCoordinator = self
        childCoordinators.append(removeCoordinator)
        removeCoordinator.start()
    }
    
    func logout() {
        parentCoordinator?.didFinishImageryTabBar()
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }

    
    deinit {
        print("FavoriteCoordinator Deinit")
    }
}


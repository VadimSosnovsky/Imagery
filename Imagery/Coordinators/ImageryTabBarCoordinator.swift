//
//  ImageryTabBarCoordinator.swift
//  Imagery
//
//  Created by Вадим Сосновский on 25.10.2022.
//

import UIKit

final class ImageryTabBarCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: AuthCoordinator?
    
    private let navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    func start() {
        let pages: [TabBarPage] = [.search, .favorite]
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        prepareTabBarController(withTabControllers: controllers)
    }
    
    func startDetailScene() {
//        let authCoordinator = AuthCoordinator(navigationController: navigationController)
//        authCoordinator.parentCoordinator = self
//        childCoordinators.append(authCoordinator)
//        authCoordinator.start()
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.tabBar.tintColor = .mainDark()
        tabBarController.selectedIndex = TabBarPage.search.pageOrderNumber()
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: true)
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: page.pageImageValue(),
                                                     tag: page.pageOrderNumber())

        switch page {
        case .search:
            let searchVC = SearchViewController()
            let searchViewModel = SearchViewModel()
            searchVC.viewModel = searchViewModel
            searchVC.didSendEventClosure = { [weak self] event in
                switch event {
                case .search:
                    self?.selectPage(.search)
                }
            }
            navigationController.pushViewController(searchVC, animated: true)
            
        case .favorite:
            let favoriteVC = FavoriteViewController()
            let favoriteViewModel = FavoriteViewModel()
            favoriteVC.viewModel = favoriteViewModel
            favoriteVC.viewModel.coordinator = self
            favoriteVC.didSendEventClosure = { [weak self] event in
                switch event {
                case .favorite:
                    self?.selectPage(.favorite)
                }
            }
            navigationController.pushViewController(favoriteVC, animated: true)
        }
        
        return navigationController
    }
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishTabBar() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}

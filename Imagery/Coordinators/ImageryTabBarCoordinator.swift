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
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.search.pageOrderNumber()
        navigationController.viewControllers = [tabBarController]
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)

        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: page.pageImageValue(),
                                                     tag: page.pageOrderNumber())

        switch page {
        case .search:
            let searchVC = SearchViewController()
            searchVC.didSendEventClosure = { [weak self] event in
                switch event {
                case .search:
                    self?.selectPage(.search)
                }
            }
            navController.pushViewController(searchVC, animated: true)
            
        case .favorite:
            let favoriteVC = FavoriteViewController()
            favoriteVC.didSendEventClosure = { [weak self] event in
                switch event {
                case .favorite:
                    self?.selectPage(.favorite)
                }
            }
            navController.pushViewController(favoriteVC, animated: true)
        }
        
        return navController
    }
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

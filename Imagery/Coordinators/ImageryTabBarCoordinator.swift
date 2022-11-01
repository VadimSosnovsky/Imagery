//
//  ImageryTabBarCoordinator.swift
//  Imagery
//
//  Created by Вадим Сосновский on 25.10.2022.
//

import UIKit

final class ImageryTabBarCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: AuthCoordinator?
    
    private let navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    func start() {
        print("ImageryTabBarCoordinator Start")
        let pages: [TabBarPage] = [.search, .favorite]
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        prepareTabBarController(withTabControllers: controllers)
        print("ImageryTabBarCoordinator childs is: \(childCoordinators)")
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
            let searchCoordinator = SearchCoordinator(navigationController: navigationController)
            searchCoordinator.parentCoordinator = self
            childCoordinators.append(searchCoordinator)
            searchCoordinator.start()
            
        case .favorite:
            let favoriteCoordinator = FavoriteCoordinator(navigationController: navigationController)
            favoriteCoordinator.parentCoordinator = self
            childCoordinators.append(favoriteCoordinator)
            favoriteCoordinator.start()
        }
        
        return navigationController
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
    
    func didFinishImageryTabBar() {
        childCoordinators = []
        parentCoordinator?.childDidFinish(self)
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("ImageryTabBarCoordinator Deinit")
    }
}

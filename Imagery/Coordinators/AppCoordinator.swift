//
//  AppCoordinator.swift
//  Imagery
//
//  Created by Вадим Сосновский on 21.10.2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let authViewController = AuthViewController()
        let authCoordinator = AuthCoordinator()
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
        
        window.rootViewController = authViewController
        window.makeKeyAndVisible()
    }
}

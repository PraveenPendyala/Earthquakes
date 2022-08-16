//
//  AppCoordinator.swift
//  Earthquakes
//
//  Created by Praveen on 8/14/22.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    let window: UIWindow?
    
    lazy var rootViewController: UINavigationController = {
        return UINavigationController()
    }()
    
    let apiClient = ApiClient()

    // MARK: - Coordinator
    init(window: UIWindow?) {
        self.window = window
    }

    override func start() {
        guard let window = window else {
            return
        }
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        goToHome()
    }

    override func finish() {

    }
    
    func goToHome() {
        let homeCoordinator = HomeCoordinator(rootViewController: rootViewController, apiClient: apiClient)
        self.addChildCoordinator(homeCoordinator)
        homeCoordinator.start()
    }

}

//
//  MainCoordinator.swift
//  GithubProfile
//
//  Created by Gabriel Conte on 01/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator{
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let clientProvider: Requester = Requester()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func start() {
        self.navigationController.navigationBar.barTintColor = Colors.navBarColor
        self.navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
        let searchProfileVC = SearchProfileViewController()
        searchProfileVC.coordinator = self
        searchProfileVC.title = "GitHub Viewer"
        navigationController.pushViewController(searchProfileVC, animated: false)
    }
    
}

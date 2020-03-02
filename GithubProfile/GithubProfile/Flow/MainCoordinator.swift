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
        setLightGrayNavBar()
        let viewModel = SearchProfileViewModel(apiClient: Requester())
        let searchProfileVC = SearchProfileViewController(with: viewModel)
        searchProfileVC.coordinator = self
        searchProfileVC.title = "GitHub Viewer"
        navigationController.pushViewController(searchProfileVC, animated: false)
    }
    
    func goToProfileDetails(profileName: String, repositories: [Project]) {
        let viewModel = ProfileDetailsViewModel(profileName: profileName, repositories: repositories)
        let profileDetailsVC = ProfileDetailsViewController(with: viewModel)
        profileDetailsVC.coordinator = self
        navigationController.pushViewController(profileDetailsVC, animated: true)
    }
    
    private func setLightGrayNavBar() {
        self.navigationController.navigationBar.barTintColor = Colors.navBarColor
        self.navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
    }
    
}

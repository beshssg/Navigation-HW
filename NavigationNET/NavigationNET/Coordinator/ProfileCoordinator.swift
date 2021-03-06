//
//  ProfileCoordinator.swift
//  NavigationNET
//
//  Created by beshssg on 01.10.2021.
//

import UIKit

final class ProfileCoordinator: NavigationCoordinator {
    var childCoordinators: [NavigationCoordinator]
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        childCoordinators = []
        self.navigationController = navigationController
    }

    func start() {
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "Profile"), selectedImage: nil)
        navigationController.tabBarItem = profileTabBarItem
    }
    
    func login() {
        let profileViewController = ProfileViewController()
        profileViewController.coordinator = self
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    func showPhotos() {
        navigationController.pushViewController(PhotosViewController(), animated: true)
    }
}

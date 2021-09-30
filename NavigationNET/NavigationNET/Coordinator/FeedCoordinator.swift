//
//  FeedCoordinator.swift
//  NavigationNET
//
//  Created by beshssg on 01.10.2021.
//

import UIKit

final class FeedCoordinator: NavigationCoordinator {
    var childCoordinators: [NavigationCoordinator]
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        childCoordinators = []
        self.navigationController = navigationController
    }

    func start() {
        let feedViewControllerTitle = "Feed"
        if let feedViewController = navigationController.viewControllers.first as? FeedViewController {
            feedViewController.title = feedViewControllerTitle
        }
        let feedTabBarItem = UITabBarItem(title: feedViewControllerTitle, image: UIImage(named: "Home"), selectedImage: nil)
        navigationController.tabBarItem = feedTabBarItem

    }
}

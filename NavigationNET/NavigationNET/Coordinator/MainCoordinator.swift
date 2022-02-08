//
//  MainCoordinator.swift
//  NavigationNET
//
//  Created by beshssg on 01.10.2021.
//

import UIKit

final class MainCoordinator {
    var childCoordinators: [NavigationCoordinator] = []
    private var rootWindow: UIWindow?
    private var tabBarController: UITabBarController

    init(rootWindow: UIWindow?) {
        self.rootWindow = rootWindow
        tabBarController = UITabBarController()
    }

    func start() {
        setupFeedCoordinator()
        setupProfileCoordinator()
        setupTabBarController()
        rootWindow?.rootViewController = self.tabBarController
        rootWindow?.makeKeyAndVisible()
    }

    private func setupFeedCoordinator() {
        let feedViewController = FeedViewController()
        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
        let feedCoordinator = FeedCoordinator(navigationController: feedNavigationController)
        feedViewController.coordinator = feedCoordinator
        feedViewController.title = "Feed"
        childCoordinators.append(feedCoordinator)
        
        let feedBarItem: UITabBarItem = {
            let tabBar = UITabBarItem()
            tabBar.image = UIImage(systemName: "tray.full.fill")
            tabBar.title = "Feed"
            tabBar.standardAppearance?.selectionIndicatorTintColor = .white
            return tabBar
        }()
        
        feedViewController.tabBarItem = feedBarItem
    }

    private func setupProfileCoordinator() {
        let loginViewController = LoginViewController()
        loginViewController.delegate = LoginInspector()
        let profileNavigationController = UINavigationController(rootViewController: loginViewController)
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        childCoordinators.append(profileCoordinator)
        
        let loginBarItem: UITabBarItem = {
            let tabBar = UITabBarItem()
            tabBar.image = UIImage(systemName: "person.crop.square.fill")
            tabBar.title = "Profile"
            tabBar.standardAppearance?.selectionIndicatorTintColor = .white
            return tabBar
        }()
        
        loginViewController.tabBarItem = loginBarItem
    }

    private func setupTabBarController() {
        var tabBarViewControllers: [UIViewController] = []
        childCoordinators.forEach {
            $0.start()
            tabBarViewControllers.append($0.navigationController)
        }
        let playerViewController = PlayerViewController()
        let playerTabBarItem = UITabBarItem(title: "Player", image: UIImage(systemName: "music.note.list"), selectedImage: nil)
        playerViewController.tabBarItem = playerTabBarItem
        tabBarViewControllers.append(playerViewController)
        
        let recordViewController = RecordViewController()
        let recordTabBarItem = UITabBarItem(title: "Recorder", image: UIImage(systemName: "mic.fill"), selectedImage: nil)
        recordViewController.tabBarItem = recordTabBarItem
        tabBarViewControllers.append(recordViewController)
        
        let postViewController = PostViewController(toDoUrl: "toDoUrl", planetUrl: "planetUrl")
        let postTabBarItem = UITabBarItem(title: "Post", image: UIImage(systemName: "paperplane.fill"), selectedImage: nil)
        postViewController.tabBarItem = postTabBarItem
        tabBarViewControllers.append(postViewController)
        
        tabBarController.viewControllers = tabBarViewControllers
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.barTintColor = .clear
        tabBarController.tabBar.backgroundColor = .black
    }
}

//
//  TabBarController.swift
//  NavigationNET
//
//  Created by beshssg on 29.08.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - UIProperties:
    let feedViewController = UINavigationController(rootViewController: FeedViewController())
    let loginViewController = UINavigationController(rootViewController: LoginViewController())
    
    let feedBarItem: UITabBarItem = {
        let tabBar = UITabBarItem()
        tabBar.image = UIImage(systemName: "tray.full.fill")
        tabBar.title = "Feed"
        tabBar.standardAppearance?.selectionIndicatorTintColor = .blue
        return tabBar
    }()
    
    let loginBarItem: UITabBarItem = {
        let tabBar = UITabBarItem()
        tabBar.image = UIImage(systemName: "person.crop.square")
        tabBar.title = "Profile"
        tabBar.standardAppearance?.selectionIndicatorTintColor = .blue
        return tabBar
    }()
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    // MARK: - Methods:
    func setupTabBar() {
        feedViewController.tabBarItem = feedBarItem
        loginViewController.tabBarItem = loginBarItem
        
        let tabBarList = [feedViewController, loginViewController]
        
        viewControllers = tabBarList
        tabBar.tintColor = .black
    }

}

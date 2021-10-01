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
        tabBar.standardAppearance?.selectionIndicatorTintColor = .white
        return tabBar
    }()
    
    let loginBarItem: UITabBarItem = {
        let tabBar = UITabBarItem()
        tabBar.image = UIImage(systemName: "person.crop.square.fill")
        tabBar.title = "Profile"
        tabBar.standardAppearance?.selectionIndicatorTintColor = .white
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
        
        feedViewController.loadViewIfNeeded()
        loginViewController.loadViewIfNeeded()
        viewControllers = tabBarList
        tabBar.tintColor = .white
        tabBar.barTintColor = .clear
        tabBar.backgroundColor = .black
    }
}

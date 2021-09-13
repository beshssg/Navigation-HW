//
//  SceneDelegate.swift
//  NavigationNET
//
//  Created by beshssg on 29.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = TabBarController()
        window.makeKeyAndVisible()
        self.window = window
        if let loginController = TabBarController().viewControllers?.first as? LoginViewController {
            loginController.delegate = MyLoginFactory()
        }
    }
}


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
        let mainCoordinator = MainCoordinator(rootWindow: window)
        mainCoordinator.start()
        self.window = window
    }
}


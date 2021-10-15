//
//  NavigationCoordinator.swift
//  NavigationNET
//
//  Created by beshssg on 01.10.2021.
//

import UIKit

protocol NavigationCoordinator: AnyObject {
    var childCoordinators: [NavigationCoordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

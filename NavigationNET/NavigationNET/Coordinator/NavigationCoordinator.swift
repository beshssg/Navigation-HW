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

extension NavigationCoordinator {
    func showAlert(presentedOn viewController: UIViewController, title: String?, message: String?, actions: [UIAlertAction] = [], completion: (() -> Void)? = nil) {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            if !actions.isEmpty {
                actions.forEach { alertController.addAction($0) }
            } else {
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            }
            viewController.present(alertController, animated: true, completion: completion)
        }
    }
    
    func closeCurrentController() {
        if let presentedViewController = navigationController.presentedViewController {
            presentedViewController.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController.popViewController(animated: true)
        }
    }
    
    func showAlertAndClose(_ viewController: UIViewController, title: String? = nil, message: String? = nil) {
        self.showAlert(presentedOn: viewController,
                       title: title ?? "Ошибка",
                       message: message,
                       actions: [UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.closeCurrentController()
        })])
    }
}

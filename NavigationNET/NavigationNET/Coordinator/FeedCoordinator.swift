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
    var selectedPostIndex: Int?

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
    
    func showPost(number index: Int) {
        guard var selectedPostIndex = selectedPostIndex else {
            guard let topViewController = navigationController.topViewController else { return }
            
            showAlert(presentedOn: topViewController, title: "Ошибка", message: "Невозможно отобразить пост")
            
            return
        }
        let url = FeedModel.shared.posts[selectedPostIndex].toDoUrl
        let postViewController = PostViewController(url: url)

        postViewController.coordinator = self

        let post = FeedModel.shared.posts[index]
        postViewController.title = post.title
        selectedPostIndex = index
        
        navigationController.pushViewController(postViewController, animated: true)
        }
    
    func showDeletePostAlert(presentedOn viewController: UIViewController) {
            let alertController = UIAlertController(title: "Удалить пост?", message: "Пост нельзя будет восстановить", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
                print("Отмена")
            }
            let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
                print("Удалить")
            }
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)

            viewController.present(alertController, animated: true, completion: nil)
        }
}

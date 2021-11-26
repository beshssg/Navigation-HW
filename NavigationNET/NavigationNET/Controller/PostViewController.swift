//
//  PostViewController.swift
//  NavigationNET
//
//  Created by beshssg on 29.08.2021.
//

import UIKit
import StorageService

class PostViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    
    var post: Post?
    var infoUrlSting: String
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        return loader
    }()
    
    private var postTitleLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 17, weight: .bold)
        title.numberOfLines = 0
        title.textAlignment = .center
        return title
    }()
    
    private lazy var alertButton: UIButton = {
        let alertButton = UIButton(type: .system)
        return alertButton
    }()
    
    private lazy var containerView: UIStackView = {
        let containerView = UIStackView(arrangedSubviews: [postTitleLabel, alertButton])
        containerView.axis = .vertical
        containerView.spacing = 16
        containerView.alpha = 0.0
        return containerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = post?.title
        setupUI()
        networkManager()
    }
    
    init(url: String) {
        infoUrlSting = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let constraints = [
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func displayUI() {
        UIView.animate(withDuration: 0.3) {
            self.loader.alpha = 0.0
        } completion: { success in
            if success {
                self.loader.stopAnimating()
                UIView.animate(withDuration: 0.3) {
                    self.containerView.alpha = 1.0
                }
            }
        }
    }
    
    func networkManager() {
        guard let url = URL(string: infoUrlSting) else {
                    print("Can't create URL from the string provided")
                    coordinator?.showAlertAndClose(self)
                    return
            }
        
        NetworkService.startDataTast(with: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print("NetworkService failure: \(error.localizedDescription)")
                self.coordinator?.showAlertAndClose(self, title: "Ошибка", message: error.localizedDescription)
            case .success(let (_, data)):
                do {
                    if let dictionary = try data.toObject(),
                       let toDo = ToDo(from: dictionary) {
                        DispatchQueue.main.async {
                            self.postTitleLabel.text = toDo.title
                            self.displayUI()
                        }
                    } else {
                        print("JSON data has unknown format")
                        self.coordinator?.showAlertAndClose(self, title: "Ошибка", message: "Данные неверного формата!")
                    }
                } catch {
                    print("Data parsing failed")
                    self.coordinator?.showAlertAndClose(self, title: "Ошибка", message: "Невозможно обработать данные!")
                }
            }
        }
    }
}


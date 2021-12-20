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
    
    private var toDoDataTask: URLSessionDataTask?
    private var planetDataTask: URLSessionDataTask?
    
    var post: Post?
    var toDoUrlString: String
    var planetUrlString: String
    
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
    
    private var planetOrbitalPeriodLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var containerView: UIStackView = {
        let containerView = UIStackView(arrangedSubviews: [postTitleLabel, alertButton, planetOrbitalPeriodLabel])
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
    
    init(toDoUrl: String, planetUrl: String) {
        toDoUrlString = toDoUrl
        planetUrlString = planetUrl
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        [containerView, loader].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
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
        guard toDoDataTask?.state != .running,
              planetDataTask?.state != .running else {
                  print("Some tasks still running")
                  return
              }
        
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
        guard let toDoUrl = URL(string: toDoUrlString),
              let planetUrl = URL(string: planetUrlString) else {
                    print("Can't create URL from the string provided")
                    coordinator?.showAlertAndClose(self)
                    return
              }
        
        toDoDataTask = NetworkService.makeDataTask(with: toDoUrl) { [weak self] result in
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
        toDoDataTask?.resume()
        
        planetDataTask = NetworkService.makeDataTask(with: planetUrl, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print("NetworkService failure: \(error.localizedDescription)")
                self.coordinator?.showAlertAndClose(self, title: "Ошибка", message: error.localizedDescription)
            case .success(let (_, data)):
                do {
                    let planet = try JSONDecoder().decode(Planet.self, from: data)
                    var name, period: String
                    
                    if let planetName = planet.name {
                        name = "планеты \"\(planetName)\""
                    } else {
                        name = "неизвестной планеты"
                    }
                    
                    if let planetPeriod = planet.orbitalPeriod {
                        let days = planetPeriod.pluralForm(of: PluralizableString(one: "день", few: "дня", many: "дней"))
                        period = "составляет \(days)"
                    } else {
                        period = "неизвестен"
                    }
                    
                    DispatchQueue.main.async {
                        self.planetOrbitalPeriodLabel.text = "Период обращения \(name) по своей орбите \(period)"
                        self.displayUI()
                    }
                } catch {
                    print("Decoding failed: \(error)")
                    self.coordinator?.showAlertAndClose(self, title: "Ошибка", message: "Возникла ошибка при распознавании данных")
                }
            }
        })
        planetDataTask?.resume()
    }
}



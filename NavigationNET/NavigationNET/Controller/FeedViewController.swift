//
//  FeedViewController.swift
//  NavigationNET
//
//  Created by beshssg on 29.08.2021.
//

import UIKit
import StorageService
import SnapKit

class FeedViewController: UIViewController {
    
    let post: Post = Post(title: "Пост")
    let model = FeedViewControllerModel()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.backgroundColor = .white
        sv.axis = .vertical
        sv.alignment = .top
        sv.spacing = 8
        return sv
    }()
    
    private let textField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .black
        text.textColor = .white
        text.placeholder = "Password"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        text.leftViewMode = .always
        text.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        text.rightViewMode = .always
        return text
    }()
    
    private lazy var checkButton: CustomButton = { [weak self] in
        let button = CustomButton(title: "Check word", color: .systemBlue, target: didTapCheckButton)
        return button
    }()
    
    let checkLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.text = "Responce"
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Feed"
        setupViews()
    }
    
    private func setupViews() {
        [textField, checkButton, checkLabel].forEach { view.addSubview($0) }
        [textField, checkButton, checkLabel].forEach { mask in
            mask.translatesAutoresizingMaskIntoConstraints = false
        }
            
        textField.snp.makeConstraints({ make in
            make.center.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        })

        checkButton.snp.makeConstraints({ make in
            make.trailing.leading.equalTo(textField)
            make.top.equalTo(textField.snp.bottom).inset(-16)
            make.height.equalTo(50)
        })
            
        checkLabel.snp.makeConstraints({ make in
            make.trailing.leading.equalTo(checkButton)
            make.top.equalTo(checkButton.snp.bottom).inset(-16)
            make.height.equalTo(50)
        })
            
        NotificationCenter.default.addObserver(forName: NSNotification.Name("green"), object: nil, queue: nil) { [self] _ in
            checkLabel.isHidden = false
            checkLabel.textColor = .systemGreen
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("red"), object: nil, queue: nil) { [self] _ in
            checkLabel.isHidden = false
            checkLabel.textColor = .systemRed
        }
    }
    
    @objc private func didTapCheckButton() {
        model.check(word: textField.text!)
    }
}

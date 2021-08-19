//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by beshssg on 27.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {

    var imageAvatar: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "10"))
        imageView.layer.borderWidth = 6
        imageView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 90
        return imageView
    }()
    
    var nameLabel: UILabel = {
       let label = UILabel()
       label.text = "Snake Eyes"
       label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
       label.tintColor = .black
       return label
    }()
    
    var statusField: UITextField = {
        let status = UITextField()
        status.placeholder = "Waiting for something..."
        status.font = UIFont.systemFont(ofSize: 18.5, weight: .regular)
        status.tintColor = .gray
        status.textAlignment = .left
        return status
    }()
    
    var pressButton: UIButton = {
       let button = UIButton()
       button.addTarget(self, action: #selector(statusTextChanged), for: .touchUpInside)
       button.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
       button.setTitle("Set status", for: .normal)
       button.setTitleColor(.white, for: .normal)
       button.backgroundColor = #colorLiteral(red: 0, green: 0.4780977368, blue: 0.9984350801, alpha: 1)
       button.layer.cornerRadius = 14
       button.layer.shadowOffset.width = 4
       button.layer.shadowOffset.height = 4
       button.layer.shadowRadius = 4
       button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
       button.layer.shadowOpacity = 0.7
       return button
    }()
    
    var statusShowText: UITextField = {
        let status = UITextField()
        status.indentText(size: 10)
        status.placeholder = "Status..."
        status.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        status.layer.cornerRadius = 12
        status.layer.borderWidth = 2
        status.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        status.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        status.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return status
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        autoLayout()
    }

    func autoLayout() {
        [imageAvatar, nameLabel, statusField, statusShowText, pressButton].forEach { addSubview($0) }
        [imageAvatar, nameLabel, statusField, statusShowText, pressButton].forEach { mask in mask.translatesAutoresizingMaskIntoConstraints = false }
        
        let constraints = [
            imageAvatar.heightAnchor.constraint(equalToConstant: 180),
            imageAvatar.widthAnchor.constraint(equalToConstant: 180),
            imageAvatar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: SetupConstraints.indent),
            imageAvatar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: SetupConstraints.indent),
            
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            nameLabel.leadingAnchor.constraint(equalTo: imageAvatar.leadingAnchor, constant: 192),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                                         
            statusField.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 100),
            statusField.leadingAnchor.constraint(equalTo: imageAvatar.leadingAnchor, constant: 192),
            statusField.trailingAnchor.constraint(equalTo: trailingAnchor),
                                         
            statusShowText.topAnchor.constraint(equalTo: statusField.topAnchor, constant: 30),
            statusShowText.leadingAnchor.constraint(equalTo: imageAvatar.safeAreaLayoutGuide.leadingAnchor, constant: 192),
            statusShowText.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -SetupConstraints.indent),
            statusShowText.heightAnchor.constraint(equalToConstant: 40),
                                         
            pressButton.topAnchor.constraint(equalTo: statusShowText.topAnchor, constant: 54),
            pressButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: SetupConstraints.indent),
            pressButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -SetupConstraints.indent),
            pressButton.heightAnchor.constraint(equalToConstant: SetupConstraints.height),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func statusTextChanged() {
        statusField.text = statusShowText.text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: Method for indentation:

extension UITextField {
    func indentText(size: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: frame.minX, y: frame.minY, width: size, height: frame.height))
        self.leftViewMode = .always
    }
}

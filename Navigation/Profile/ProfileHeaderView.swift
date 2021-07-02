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
        let imageView = UIImageView(image: #imageLiteral(resourceName: "snake_eyes"))
        imageView.layer.borderWidth = 6
        imageView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 90
        return imageView
        
        
    }()
    
    var nameLabel: UILabel = {
       let name = UILabel()
       name.text = "Snake Eyes"
       name.font = UIFont.systemFont(ofSize: 25, weight: .bold)
       name.tintColor = .black
       return name
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
       button.addTarget(self, action: #selector(statusTextChanged(textStatus:)), for: .touchUpInside)
       button.addTarget(self, action: #selector(statusTextChanged(textStatus:)), for: .editingChanged)
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
        status.indent(size: 10)
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
        [imageAvatar, nameLabel, statusField, statusShowText, pressButton].forEach { mask in
            mask.translatesAutoresizingMaskIntoConstraints = false
        }
        autoLayout()
    }

    func autoLayout() {
        addSubview(imageAvatar)
        addSubview(nameLabel)
        addSubview(statusField)
        addSubview(statusShowText)
        addSubview(pressButton)
        
        NSLayoutConstraint.activate([imageAvatar.heightAnchor.constraint(equalToConstant: 180),
                                     imageAvatar.widthAnchor.constraint(equalToConstant: 180),
                                     imageAvatar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
                                     imageAvatar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
                                     
                                     nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
                                     nameLabel.leadingAnchor.constraint(equalTo: imageAvatar.leadingAnchor, constant: 192),
                                     nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     
                                     statusField.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 100),
                                     statusField.leadingAnchor.constraint(equalTo: imageAvatar.leadingAnchor, constant: 192),
                                     statusField.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     
                                     statusShowText.topAnchor.constraint(equalTo: statusField.topAnchor, constant: 30),
                                     statusShowText.leadingAnchor.constraint(equalTo: imageAvatar.safeAreaLayoutGuide.leadingAnchor, constant: 192),
                                     statusShowText.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
                                     statusShowText.heightAnchor.constraint(equalToConstant: 40),
                                     
                                     pressButton.topAnchor.constraint(equalTo: statusShowText.topAnchor, constant: 54),
                                     pressButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
                                     pressButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
                                     pressButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func statusTextChanged(textStatus: UIButton) {
        statusField.text = statusShowText.text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: Method for indentation:

extension UITextField {
    func indent(size: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}

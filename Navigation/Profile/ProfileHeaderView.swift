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
        let image: UIImage = UIImage(named: "snake_eyes")!
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 16, y: 116, width: 200, height: 200)
        imageView.layer.borderWidth = 6
        imageView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var nameLabel: UILabel = {
       let name = UILabel(frame: CGRect(x: 222, y: 56, width: 200, height: 200))
       name.text = "Snake Eyes"
       name.font = UIFont.systemFont(ofSize: 30, weight: .bold)
       name.tintColor = .black
       return name
    }()
    
    var statusField: UITextField = {
        let status = UITextField(frame: CGRect(x: 224, y: 148, width: 200, height: 200))
        status.placeholder = "Waiting for something..."
        status.font = UIFont.systemFont(ofSize: 18.5, weight: .regular)
        status.tintColor = .gray
        status.textAlignment = .left
        return status
    }()
    
    var pressButton: UIButton = {
       let button = UIButton(frame: CGRect(x: 16, y: 338, width: 390, height: 70))
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
       button.layer.shadowOpacity = 2
       return button
    }()
    
    var statusShowText: UITextField = {
        let status = UITextField(frame: CGRect(x: 220, y: 278, width: 200, height: 40))
        status.indent(size: 10)
        status.placeholder = "Status..."
        status.backgroundColor = .white
        status.layer.cornerRadius = 12
        status.layer.borderWidth = 2
        status.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        status.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        status.textColor = .black
        return status
    }()
    
   // Method for printing the status in the console

//    @objc func pressButtonFunc(sender: UIButton) {
//        print(statusField.text!)
//
//    }
    
    @objc func statusTextChanged(textStatus: UIButton) {
        print(statusShowText.text = statusField.text)
    }
}

// MARK: Method for indentation:

extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}




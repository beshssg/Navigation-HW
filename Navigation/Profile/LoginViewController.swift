//
//  LoginViewController.swift
//  Navigation
//
//  Created by beshssg on 06.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let scrollView = UIScrollView()
    
    var logoImage: UIImageView = {
       let logo = UIImageView(image: #imageLiteral(resourceName: "logo"))
        return logo
    }()
    
    var emailText: UITextField = {
        let text = UITextField()
        text.placeholder = "Email or phone"
        text.indent(size: 10)
        text.backgroundColor = .systemGray6
        text.autocorrectionType = .no
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 16)
        text.layer.borderColor = UIColor.lightGray.cgColor
        text.layer.borderWidth = 0.5
        text.layer.cornerRadius = 10
        text.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return text
   }()
    
    var passwordText: UITextField = {
        let text = UITextField()
        text.placeholder = "Password"
        text.isSecureTextEntry = true
        text.indent(size: 10)
        text.backgroundColor = .systemGray6
        text.autocorrectionType = .no
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 16)
        text.layer.borderColor = UIColor.lightGray.cgColor
        text.layer.borderWidth = 0.5
        text.layer.cornerRadius = 10
        text.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return text
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIColor.init(named: "#4885CC")
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupConstraints() {
        [scrollView, logoImage, emailText, passwordText, loginButton].forEach { view.addSubview($0) }
        [scrollView, logoImage, emailText, passwordText, loginButton].forEach { make in make.translatesAutoresizingMaskIntoConstraints = false }
        
        let constraints = [
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            
            emailText.bottomAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            emailText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailText.heightAnchor.constraint(equalToConstant: 50),
            
            passwordText.bottomAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 48),
            passwordText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordText.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.bottomAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 68),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func keyboardShow(_ notification: Notification) {
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardSize!.height)
            
        
    }
    
    @objc func keyboardHide(_ notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
    
    @objc func buttonTapped(sender: UIButton) {
        let pvc = ProfileViewController()
        navigationController?.pushViewController(pvc, animated: true)
    }
    
}


//
//  LoginViewController.swift
//  NavigationNET
//
//  Created by beshssg on 29.08.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - UIProperties:
    private let scrollView = UIScrollView()
    
    private let currentUser = CurrentUser()
    private let testUser = TestUserService()
    
    var delegate: LoginViewControllerDelegate?
    
    private lazy var logoImage: UIImageView = {
        let logo = UIImageView(image: #imageLiteral(resourceName: "logo"))
        return logo
    }()
    
    lazy var emailText: UITextField = {
        let text = UITextField()
        text.placeholder = "Email or phone"
        text.indentText(size: 10)
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
    
    lazy var passwordText: UITextField = {
        let text = UITextField()
        text.placeholder = "Password"
        text.isSecureTextEntry = true
        text.indentText(size: 10)
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
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    // MARK: - Methods:
    private func setupConstraints() {
        view.addSubview(scrollView)
        [logoImage, emailText, passwordText, loginButton].forEach { scrollView.addSubview($0) }
        [scrollView, logoImage, emailText, passwordText, loginButton].forEach { make in make.translatesAutoresizingMaskIntoConstraints = false }
        scrollView.keyboardDismissMode = .onDrag
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            logoImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            
            emailText.bottomAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            emailText.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: SetupConstraints.indent),
            emailText.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -SetupConstraints.indent),
            emailText.heightAnchor.constraint(equalToConstant: 50),
            
            passwordText.bottomAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 48),
            passwordText.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: SetupConstraints.indent),
            passwordText.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -SetupConstraints.indent),
            passwordText.heightAnchor.constraint(equalToConstant: SetupConstraints.height),
            
            loginButton.bottomAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 68),
            loginButton.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: SetupConstraints.indent),
            loginButton.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -SetupConstraints.indent),
            loginButton.heightAnchor.constraint(equalToConstant: SetupConstraints.height),
            loginButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func keyboardShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = .zero
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardHide(_ notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc private func buttonTapped() {
        #if RELEASE
        let loginText = emailText.text ?? ""
        let passwordText = passwordText.text ?? ""
        
        guard (delegate?.checkerLogin(login: loginText, password: passwordText)) != nil else {
                let pvc = ProfileViewController()
                navigationController?.pushViewController(pvc, animated: true)
                print("Correct login")
            return
        }
//        if let enteredNamed = emailText.text, (testUser.userService(userName: enteredNamed) != nil) {
//            let pvc = ProfileViewController(userService: testUser, userNames: enteredNamed)
//            navigationController?.pushViewController(pvc, animated: true)
//            print("Correct login")
//        } else {
//            print("Wrong login")
        #else
        let loginText = emailText.text ?? ""
        let passwordText = passwordText.text ?? ""
        
        guard (delegate?.checkerLogin(login: loginText, password: passwordText)) != nil else {
                let pvc = ProfileViewController()
                navigationController?.pushViewController(pvc, animated: true)
                print("Correct login")
            return
        }
        #endif
    }
}

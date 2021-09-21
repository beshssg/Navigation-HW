//
//  LoginInspector.swift
//  NavigationNET
//
//  Created by beshssg on 12.09.2021.
//

import UIKit

class LoginInspector: LoginViewControllerDelegate {
    func checkerLogin(login: String, password: String) -> Bool {
        return Checker.shared.isLoginAndPasswordCorrect(login: login, password: password)
    }
}

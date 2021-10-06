//
//  LoginInspector.swift
//  NavigationNET
//
//  Created by beshssg on 12.09.2021.
//

import UIKit

class LoginInspector: LoginViewControllerDelegate {
    func checkerLogin(emailOrPhone: String, password: String) -> Bool {
        return Checker.checker.check(emailOrPhone: emailOrPhone, password: password)
    }
}

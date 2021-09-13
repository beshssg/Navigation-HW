//
//  LoginInspector.swift
//  NavigationNET
//
//  Created by beshssg on 12.09.2021.
//

import UIKit

class LoginInspector {
    func checkLogin(controller: LoginViewController) -> Bool {
        guard controller.emailText.text?.hash == Checker.checker.login &&
              controller.passwordText.text?.hash == Checker.checker.password else { return false }
        return true
    }
}


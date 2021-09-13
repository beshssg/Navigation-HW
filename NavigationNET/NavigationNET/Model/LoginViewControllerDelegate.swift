//
//  LoginViewControllerDelegate.swift
//  NavigationNET
//
//  Created by beshssg on 12.09.2021.
//

import UIKit

protocol LoginViewControllerDelegate {
    func checkLogin(controller: LoginViewController) -> Bool
}

protocol LoginFactory {
    func inspector() -> LoginInspector
}

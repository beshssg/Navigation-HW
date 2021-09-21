//
//  LoginViewControllerDelegate.swift
//  NavigationNET
//
//  Created by beshssg on 12.09.2021.
//

import UIKit

protocol LoginViewControllerDelegate {
    func checkerLogin(login : String, password : String) -> Bool
}

protocol LoginFactory {
    func createInspector() -> LoginViewControllerDelegate
}




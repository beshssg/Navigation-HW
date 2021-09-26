//
//  MyLoginFactory.swift
//  NavigationNET
//
//  Created by beshssg on 13.09.2021.
//

import UIKit

class MyLoginFactory: LoginFactory {
    func createInspector() -> LoginViewControllerDelegate {
        return LoginInspector()
    }
}

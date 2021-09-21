//
//  Checker.swift
//  NavigationNET
//
//  Created by beshssg on 12.09.2021.
//

import UIKit

class Checker {
    static let shared = Checker(login: "SnakeEyes", password: "qwerty123")
    
    private let loginHash : Int
    private let passwordHash : Int
    
    private init(login : String, password : String) {
        self.loginHash = login.hash
        self.passwordHash = password.hash
    }
    
    public func isLoginAndPasswordCorrect(login : String, password : String) -> Bool {
        let inputLoginHash = login.hash
        let inputPasswordHash = password.hash
        return inputLoginHash == self.loginHash && inputPasswordHash == self.passwordHash
    }
}

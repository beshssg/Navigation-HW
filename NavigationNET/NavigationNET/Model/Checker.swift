//
//  Checker.swift
//  NavigationNET
//
//  Created by beshssg on 12.09.2021.
//

import UIKit

class Checker {
    static let shared = Checker()
    
    private(set) var login = "Snake Eyes".hash
    private(set) var password = "p".hash
    
    private init() {}
    
    func check(emailOrPhone: String, password: String) -> Bool {
        if emailOrPhone.hash == login && password.hash == self.password {
            return true
        }
        return false
    }
}

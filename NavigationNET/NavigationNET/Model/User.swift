//
//  User.swift
//  NavigationNET
//
//  Created by beshssg on 09.09.2021.
//

import UIKit

class User {
    var fullName: String
    var avatar: UIImage
    var status: String
    
    init(fullName: String, avatar: UIImage, status: String) {
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
    
}

protocol UserService {
    func userService(userName: String) -> User?
}

class CurrentUser: UserService {
    let user = User(fullName: "SnakeEyes", avatar: UIImage(named: "marvel")!, status: "Snake")
    
    func userService(userName: String) -> User? {
        if userName == user.fullName {
            return user
        } else {
            return nil
        }
    }
}

class TestUserService: UserService {
    let user = User(fullName: "TestSnakeEyes", avatar: UIImage(named: "mem")!, status: "TestSnake")
    
    func userService(userName: String) -> User? {
        if userName == user.fullName {
            return user
        } else {
        return nil
        }
    }
    
}

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
<<<<<<< HEAD
    let user = User(fullName: "Snake Eyes", avatar: UIImage(named: "17")!, status: "Snake")
=======
    let user = User(fullName: "SnakeEyes", avatar: UIImage(named: "3")!, status: "asd")
>>>>>>> hwSingleton
    
    func userService(userName: String) -> User? {
        if userName == user.fullName {
            return user
        } else {
            return nil
        }
    }
}

class TestUserService: UserService {
<<<<<<< HEAD
    let user = User(fullName: "Test Snake Eyes", avatar: UIImage(named: "13")!, status: "Test Snake")
=======
    let user = User(fullName: "TestSnakeEyes", avatar: UIImage(named: "5")!, status: "asd")
>>>>>>> hwSingleton
    
    func userService(userName: String) -> User? {
        if userName == user.fullName {
            return user
        } else {
            return nil
        }
    }
    
}

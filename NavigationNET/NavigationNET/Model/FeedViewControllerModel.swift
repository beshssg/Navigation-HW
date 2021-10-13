//
//  FeedViewControllerModel.swift
//  NavigationNET
//
//  Created by beshssg on 26.09.2021.
//

import Foundation

class FeedViewControllerModel {
    private let password = "Snake"
        
    func check(word: String) {
        if word == password {
            NotificationCenter.default.post(name: NSNotification.Name("green"), object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("red"), object: nil)
        }
    }
}

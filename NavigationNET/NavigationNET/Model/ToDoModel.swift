//
//  ToDoModel.swift
//  NavigationNET
//
//  Created by beshssg on 25.11.2021.
//

import UIKit

struct ToDo {
    var id: Int
    var userId: Int
    var title: String
    var completed: Bool
    
    init(id: Int, userId: Int, title: String, completed: Bool) {
        self.id = id
        self.userId = userId
        self.title = title
        self.completed = completed
    }
    
    init?(from dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
              let userId = dictionary["userId"] as? Int,
              let title = dictionary["title"] as? String,
              let completed = dictionary["completed"] as? Bool else { return nil }
        
        self.init(id: id, userId: userId, title: title, completed: completed)
    }
}

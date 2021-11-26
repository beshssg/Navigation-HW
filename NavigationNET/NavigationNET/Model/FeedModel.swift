//
//  FeedModel.swift
//  NavigationNET
//
//  Created by beshssg on 13.10.2021.
//

import UIKit

struct FeedModel {

    static let shared: FeedModel = {
        let instance = FeedModel()
        return instance
    }()
    
    var posts = [PostDummy]()
    
    private init() {
        
        for index in 1...Int.random(in: 2...10) {
            posts.append(PostDummy(title: "Пост \(index)",
                                   toDoUrl: "https://jsonplaceholder.typicode.com/todos/\(index)"))
        }
    }
}

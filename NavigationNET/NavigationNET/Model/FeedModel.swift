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

    let posts: [PostDummy]

    private init() {
        posts = [
            PostDummy(title: "Пост 1"),
            PostDummy(title: "Пост 2")
        ]
    }
}

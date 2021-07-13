//
//  PostModel.swift
//  Navigation
//
//  Created by beshssg on 10.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

struct PostModel {
    var author: String
    var description: String
    var image: UIImage
    var likes: Int
    var views: Int
}

struct Storage {
    static let tableModel = [
        PostModel(author: "Netflix", description: "Встречаем первый трейлер второго сезона сериала «Ведьмак» Ожидаем премьеру 17 декабря.", image: #imageLiteral(resourceName: "vedmak"), likes: 62446, views: 124463),
        PostModel(author: "Marvel", description: "Зомби-версии Кэпа и Старка выглядят просто отлично!", image: #imageLiteral(resourceName: "marvel"), likes: 111324, views: 231324),
        PostModel(author: "Наука и Техника", description: "", image: #imageLiteral(resourceName: "hacker"), likes: 225320, views: 542320),
        PostModel(author: "На Случай Важных Переговоров", description: "", image: #imageLiteral(resourceName: "mem"), likes: 107389, views: 217389)
    ]
}


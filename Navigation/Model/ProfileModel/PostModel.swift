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

struct GalleryPhotos {
    var image: UIImage
}

struct Storage {
    static let tableModel = [
        PostModel(author: "Netflix", description: "Встречаем первый трейлер второго сезона сериала «Ведьмак» Ожидаем премьеру 17 декабря.", image: UIImage(named: "vedmak")!, likes: 62446, views: 124463),
        PostModel(author: "Marvel", description: "Зомби-версии Кэпа и Старка выглядят просто отлично!", image: UIImage(named: "marvel")!, likes: 111324, views: 231324),
        PostModel(author: "Наука и Техника", description: "", image: UIImage(named: "hacker")!, likes: 225320, views: 542320),
        PostModel(author: "На Случай Важных Переговоров", description: "", image: UIImage(named: "mem")!, likes: 107389, views: 217389)
    ]
    
    static let galleryPhotos = [
        GalleryPhotos(image: UIImage(named: "1")!),
        GalleryPhotos(image: UIImage(named: "2")!),
        GalleryPhotos(image: UIImage(named: "3")!),
        GalleryPhotos(image: UIImage(named: "4")!),
        GalleryPhotos(image: UIImage(named: "5")!),
        GalleryPhotos(image: UIImage(named: "6")!),
        GalleryPhotos(image: UIImage(named: "7")!),
        GalleryPhotos(image: UIImage(named: "8")!),
        GalleryPhotos(image: UIImage(named: "9")!),
        GalleryPhotos(image: UIImage(named: "10")!),
        GalleryPhotos(image: UIImage(named: "11")!),
        GalleryPhotos(image: UIImage(named: "12")!),
        GalleryPhotos(image: UIImage(named: "13")!),
        GalleryPhotos(image: UIImage(named: "14")!),
        GalleryPhotos(image: UIImage(named: "15")!),
        GalleryPhotos(image: UIImage(named: "16")!),
        GalleryPhotos(image: UIImage(named: "17")!),
        GalleryPhotos(image: UIImage(named: "18")!),
        GalleryPhotos(image: UIImage(named: "19")!),
        GalleryPhotos(image: UIImage(named: "20")!),
    ]
}


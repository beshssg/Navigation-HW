//
//  PostButtonFactory.swift
//  NavigationNET
//
//  Created by beshssg on 13.10.2021.
//

import UIKit

struct PostButtonFactory {
    static func makeButtonForPost(index: Int) -> PostButton {
        let button = PostButton(type: .system)
        button.setTitle("Show post \(index + 1)", for: .normal)
        button.sizeToFit()
        button.index = index
        return button
    }
}

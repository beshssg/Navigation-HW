//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by beshssg on 27.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {

    var imageAvatar: UIImageView = {
        var image: UIImage = UIImage(named: "snake_eyes")!
        var imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 10, y: 104, width: 200, height: 200)
        imageView.layer.borderWidth = 6
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var name: UILabel = {
       let name = UILabel(frame: CGRect(x: 222, y: 48, width: 200, height: 200))
        name.text = "Snake Eyes"
        name.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        name.tintColor = .black
        return name
    }()
    
    

    

}




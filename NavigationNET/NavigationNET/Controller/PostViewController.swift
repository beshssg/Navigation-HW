//
//  PostViewController.swift
//  NavigationNET
//
//  Created by beshssg on 29.08.2021.
//

import UIKit

class PostViewController: UIViewController {
    
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = post?.title
    }

}
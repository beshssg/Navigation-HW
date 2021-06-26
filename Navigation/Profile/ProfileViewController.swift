//
//  ProfileViewController.swift
//  Navigation
//
//  Created by beshssg on 26.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let profileHeaderView = ProfileHeaderView()
        
        view.addSubview(profileHeaderView.starButton)
    }
    

    
}

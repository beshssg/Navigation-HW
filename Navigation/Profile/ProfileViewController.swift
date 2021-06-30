//
//  ProfileViewController.swift
//  Navigation
//
//  Created by beshssg on 27.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        view.addSubview(profileHeaderView)
        
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        profileHeaderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        profileHeaderView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 2).isActive = true

        
    }
    
    
   
}



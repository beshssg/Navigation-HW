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
    
    var tableView = UITableView(frame: .zero, style: .plain)
    var cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        profileViewSetup()
        
    }
    
    func profileViewSetup() {
        [profileHeaderView, tableView].forEach { view.addSubview($0) }
        [profileHeaderView, tableView].forEach { mask in mask.translatesAutoresizingMaskIntoConstraints = false }
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        
        let constraints = [
            profileHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -94),
            profileHeaderView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 4),
        
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
        
        
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Storage.tableModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PostTableViewCell
        cell.postModel = Storage.tableModel[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

//
//  ProfileViewController.swift
//  Navigation
//
//  Created by beshssg on 27.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileHeaderView = ProfileHeaderView()
    
    private let postTableView = UITableView(frame: .zero, style: .plain)
    
    private lazy var photosCollectionView = UITableView(frame: .zero, style: .plain)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        profileViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func profileViewSetup() {
        [profileHeaderView, postTableView, photosCollectionView].forEach { view.addSubview($0) }
        [profileHeaderView, postTableView, photosCollectionView].forEach { mask in mask.translatesAutoresizingMaskIntoConstraints = false }
        
        photosCollectionView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        photosCollectionView.backgroundColor = .white
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        
        postTableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        postTableView.backgroundColor = .black
        postTableView.dataSource = self
        postTableView.delegate = self
        
        let constraints = [
            profileHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: photosCollectionView.topAnchor, constant: -94),
            profileHeaderView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 4),
            
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photosCollectionView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 6),
            photosCollectionView.bottomAnchor.constraint(equalTo: postTableView.topAnchor, constant: -20),
            
            postTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == postTableView {
            return Storage.tableModel.count
        }
        else if (tableView == photosCollectionView) {
            return 1
        }
        return Int()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == postTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
            cell.postModel = Storage.tableModel[indexPath.row]
            return cell
        }
        else if (tableView == photosCollectionView) {
            switch indexPath.row {
                    case 0:
                        let tb = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
                        tb.goGalleryClosure = {
                            let pvc = PhotosViewController()
                            self.navigationController?.pushViewController(pvc, animated: true)
                        }
                        return tb
                    default:
                        ()
                    }
                    return UITableViewCell()
                }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == postTableView {
            return 1
        }
        else if (tableView == photosCollectionView) {
            return 1
        }
        return 1
    }
}


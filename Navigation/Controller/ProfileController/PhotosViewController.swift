//
//  PhotosViewController.swift
//  Navigation
//
//  Created by beshssg on 18.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    lazy var pcv: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.contentMode = .scaleAspectFit
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        navigationBarSetup()
    }
    
    func setupCV() {
        view.addSubview(pcv)
        pcv.translatesAutoresizingMaskIntoConstraints = false
        pcv.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        pcv.delegate = self
        pcv.dataSource = self
        
        let constraints = [
            pcv.topAnchor.constraint(equalTo: view.topAnchor),
            pcv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pcv.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pcv.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func navigationBarSetup() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Photo Gallery"
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Storage.galleryPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self),
                                                      for: indexPath) as! PhotosCollectionViewCell
        cell.photosModel = Storage.galleryPhotos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 130)
    }

}

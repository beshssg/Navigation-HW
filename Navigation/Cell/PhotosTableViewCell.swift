//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by beshssg on 23.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    var goGalleryClosure: (() -> Void)?
    
    var photosModel: GalleryPhotos? {
        didSet {
            imageGallery.image = photosModel?.image
        }
    }
    
    private var imageGallery: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        return image
    }()
    
    lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.backgroundColor = .white
        cv.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var galleryButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(goToGalleryButton), for: .touchUpInside)
        return button
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupTableViews()
    }
    
    func setupTableViews() {
        [titleLabel, galleryButton, photosCollectionView].forEach { contentView.addSubview($0) }
        [titleLabel, galleryButton, photosCollectionView].forEach { mask in mask.translatesAutoresizingMaskIntoConstraints = false }
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: SetupConstraints.indent2),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: SetupConstraints.indent2),
            
            galleryButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: SetupConstraints.indent2),
            galleryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -SetupConstraints.indent2),
            
            photosCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photosCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func goToGalleryButton() {
        goGalleryClosure!()
    }
}

extension PhotosTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self),
                                                      for: indexPath) as! PhotosCollectionViewCell
        cell.photosModel = Storage.galleryPhotos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 95, height: 85)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: SetupConstraints.indent2, left: SetupConstraints.indent2, bottom: 0, right: SetupConstraints.indent2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}


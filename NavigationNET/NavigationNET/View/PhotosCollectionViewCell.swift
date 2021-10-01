//
//  PhotosCollectionViewCell.swift
//  NavigationNET
//
//  Created by beshssg on 29.08.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UIProperties:
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
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods:
    func setupViews() {
        [imageGallery].forEach { contentView.addSubview($0) }
        [imageGallery].forEach { mask in mask.translatesAutoresizingMaskIntoConstraints = false }
        
        let constraints = [
            contentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageGallery.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageGallery.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageGallery.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageGallery.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

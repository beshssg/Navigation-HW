//
//  PostTableViewCell.swift
//  NavigationNET
//
//  Created by beshssg on 29.08.2021.
//

import UIKit
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    
    // MARK: - UIProperties:
    let imageProcessor = ImageProcessor()
    
    var postModel: PostModel? {
        didSet {
            authorLabel.text = postModel?.author
            imagePost.image = postModel?.image
            descriptionLabel.text = postModel?.description
            likesLabel.text = "Likes: \(String(postModel!.likes))"
            viewsLabel.text = "Views: \(String(postModel!.views))"
        
            imageProcessor.processImage(sourceImage: imagePost.image!, filter: .chrome, completion: { resultImage in imagePost.image = resultImage })
        }
    }
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var imagePost: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Lifecycle:
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTableViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableViews()
    }
    
    // MARK: - Methods:
    private func setupTableViews() {
        [authorLabel, imagePost, descriptionLabel, likesLabel, viewsLabel].forEach { contentView.addSubview($0) }
        [authorLabel, imagePost, descriptionLabel, likesLabel, viewsLabel].forEach { mask in
            mask.translatesAutoresizingMaskIntoConstraints = false }
        
        let constraints = [
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: SetupConstraints.indent),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: SetupConstraints.indent),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            authorLabel.bottomAnchor.constraint(equalTo: imagePost.topAnchor, constant: -SetupConstraints.indent2),
                        
            imagePost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagePost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imagePost.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -SetupConstraints.indent),
            imagePost.heightAnchor.constraint(equalToConstant: 400),
                        
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: SetupConstraints.indent),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -SetupConstraints.indent),
            descriptionLabel.bottomAnchor.constraint(equalTo: likesLabel.topAnchor, constant: -SetupConstraints.indent),
                        
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: SetupConstraints.indent),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -SetupConstraints.indent),
            
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -SetupConstraints.indent),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -SetupConstraints.indent),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

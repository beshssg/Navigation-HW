//
//  ProfileViewController.swift
//  NavigationNET
//
//  Created by beshssg on 29.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - UIProperties:
    private let profileHeaderView = ProfileHeaderView()
    
    private let postTableView = UITableView(frame: .zero, style: .plain)
    
    private lazy var photosCollectionView = UITableView(frame: .zero, style: .plain)
    
    private lazy var closeButton: UIButton = {
        var button = UIButton()
        button.sizeToFit()
        button.setImage(UIImage(systemName: "multiply"), for: button.state)
        button.tintColor = #colorLiteral(red: 0.1176327839, green: 0.1176561788, blue: 0.117627643, alpha: 0.9985017123).withAlphaComponent(0)
        button.isUserInteractionEnabled = true
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closedButton))
        button.addGestureRecognizer(tapGestureRecognizer)
        return button
    }()
    
    private lazy var backgroundPhotos: UIView = {
        var view = UIView()
        view.frame = UIScreen.main.bounds
        var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        return view
    }()
    
    private lazy var photosFullScreen = UIImageView(image: profileHeaderView.imageAvatar.image)
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileViewSetup()
        testBackground()
        animatedAvatar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    init(userService: UserService, userNames: String) {
//            self.userService = userService
//            self.userNames = userNames
//            super.init(nibName: nil, bundle: nil)
//        }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    // MARK: - Methods:
    func profileViewSetup() {
        [profileHeaderView, postTableView, photosCollectionView, closeButton].forEach { view.addSubview($0) }
        [profileHeaderView, postTableView, photosCollectionView, closeButton].forEach { mask in mask.translatesAutoresizingMaskIntoConstraints = false }
        
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
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func testBackground() {
        #if RELEASE
        view.backgroundColor = .white
        #else
        view.backgroundColor = .red
        #endif
    }
    
    // MARK: - Animation methods:
    func animatedAvatar() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(photoFullScreen))
        profileHeaderView.imageAvatar.addGestureRecognizer(tapGestureRecognizer)
        profileHeaderView.imageAvatar.isUserInteractionEnabled = true
    }
    
    @objc private func photoFullScreen() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) { [self] in
                view.addSubview(backgroundPhotos)
                
                backgroundPhotos.alpha = 1
                closeButton.alpha = 1
                photosFullScreen.alpha = 1
                
                closeButton.frame = CGRect(
                    x: backgroundPhotos.bounds.maxX - 32,
                    y: backgroundPhotos.bounds.minY + 16,
                    width: closeButton.frame.width,
                    height: closeButton.frame.height)
                
                backgroundPhotos.addSubview(photosFullScreen)
                backgroundPhotos.addSubview(closeButton)
                
                photosFullScreen.center = backgroundPhotos.center
                photosFullScreen.transform = CGAffineTransform(scaleX: 2, y: 2)
                photosFullScreen.contentMode = .scaleAspectFill
                photosFullScreen.layer.masksToBounds = false
                photosFullScreen.layer.cornerRadius = 0
                photosFullScreen.layer.borderWidth = 0
            }
        } completion: { _ in
            UIView.animateKeyframes(withDuration: 0.3, delay: 0.5, options: []) { [self] in
                closeButton.tintColor = #colorLiteral(red: 0.1176327839, green: 0.1176561788, blue: 0.117627643, alpha: 1).withAlphaComponent(0.6)
            }
        }
    }
    
    @objc private func closedButton() {
        UIView.animate(withDuration: 0.5, animations: { [self] in
            backgroundPhotos.alpha = 0.0
            closeButton.alpha = 0.0
            photosFullScreen.alpha = 0.0
                       }) { [self] _ in
            backgroundPhotos.removeFromSuperview()
            closeButton.removeFromSuperview()
        photosFullScreen.removeFromSuperview()
        }
    }
}

     // MARK: - Delegate
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

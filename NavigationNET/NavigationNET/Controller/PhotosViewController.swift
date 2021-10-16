//
//  PhotosViewController.swift
//  NavigationNET
//
//  Created by beshssg on 29.08.2021.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController, ImageLibrarySubscriber {
    
    // MARK: - UIProperties:
    var imagePublisherFacade = ImagePublisherFacade()
    var imageViews = [UIImageView]()
    var imageProcessor = ImageProcessor()
    
    lazy var pcv: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.contentMode = .scaleAspectFit
        return cv
    }()
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCV()
        navigationBarSetup()
        imagePublisherFacade.subscribe(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        imagePublisherFacade.removeSubscription(for: self)
        imagePublisherFacade.rechargeImageLibrary()
    }
    
    // MARK: - Methods:
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
    
    func receive(images: [UIImage]) {
        imageViews.append(UIImageView(image: images[images.count - 1]))
        pcv.reloadItems(at: [IndexPath(item: images.count - 1, section: 0)])
    }
    
    func navigationBarSetup() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Photo Gallery"
    }
    
    func imageThread() {
        var firstImages = [UIImage]()
                let secondImages = [UIImage(named: "1")!, UIImage(named: "2")!]
                let thirdImages = [UIImage(named: "3")!, UIImage(named: "4")!]
                let fourthImages = [UIImage(named: "5")!, UIImage(named: "6")!]
                let fifthImages = [UIImage(named: "7")!, UIImage(named: "8")!]

                imageViews.forEach({firstImages.append($0.image!)})

                imageProcessor.processImagesOnThread(sourceImages: firstImages, filter: .colorInvert,
                                                     qos: .background) { images in
                    for i in 0 ..< images.count {
                        DispatchQueue.main.async {
                            self.imageViews[i].image = UIImage(cgImage: images[i]!)
                        }
                    }

                } // 616
                
        imageProcessor.processImagesOnThread(sourceImages: secondImages, filter: .noir,
                                                     qos: .default) { images in
                    for i in 0 ..< images.count {
                        DispatchQueue.main.async {
                            self.imageViews.append(UIImageView(image: UIImage(cgImage: images[i]!)))
                        }
                    }
                } // 62
                
        imageProcessor.processImagesOnThread(sourceImages: thirdImages, filter: .chrome,
                                                     qos: .userInitiated) { images in
                    for i in 0 ..< images.count {
                        DispatchQueue.main.async {
                            self.imageViews.append(UIImageView(image: UIImage(cgImage: images[i]!)))
                        }
                    }
                } // 36
                
        imageProcessor.processImagesOnThread(sourceImages: fourthImages, filter: .fade,
                                                     qos: .userInteractive) { images in
                    for i in 0 ..< images.count {
                        DispatchQueue.main.async {
                            self.imageViews.append(UIImageView(image: UIImage(cgImage: images[i]!)))
                        }
                    }
                } // 43
                
        imageProcessor.processImagesOnThread(sourceImages: fifthImages, filter: .posterize,
                                                     qos: .utility) { images in
                    for i in 0 ..< images.count {
                        DispatchQueue.main.async {
                            self.imageViews.append(UIImageView(image: UIImage(cgImage: images[i]!)))
                        }
                    }
                } // 1068
    }
}

     // MARK: - Delegate
extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self),
                                                      for: indexPath) as! PhotosCollectionViewCell
        
        guard imageViews.isEmpty == false else {
            return cell
        }
        
        cell.imageGallery = imageViews[indexPath.item]
        return cell
    }
}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 130)
    }



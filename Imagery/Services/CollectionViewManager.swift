//
//  CollectionViewManager.swift
//  Imagery
//
//  Created by Вадим Сосновский on 26.10.2022.
//

import UIKit

class CollectionViewManager: NSObject {
    
    var selectedImage: UIImage?
    var onUpdate = {}
    var completion: (UIImage) -> Void = { _ in }
    
    var collectionView: UICollectionView = {
        let layout = PinterestLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.isUserInteractionEnabled = true
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .mainWhite()
        
        return collectionView
    }()
    
    var viewModel: CollectionViewCellViewModel!
    
    var pictureInfo = [Result]() {
        didSet {
            images = []
            collectionView.reloadData()
            viewModel.loadImages(from: pictureInfo) { image in
                self.images.append(image)
            }
        }
    }
    
    var images = [UIImage]() {
        didSet {
            if images.count == pictureInfo.count {
                self.collectionView.reloadData()
                onUpdate()
            }
        }
    }
    
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }
    }
}

extension CollectionViewManager: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }

        cell.configure(with: self.images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        completion(self.images[indexPath.row])
    }
}

extension CollectionViewManager: PinterestLayoutDelegate {
    func cellSize(indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2, height: images[indexPath.row].size.height / 6)
    }
}

//
//  CollectionViewManager.swift
//  Imagery
//
//  Created by Вадим Сосновский on 26.10.2022.
//

import UIKit

class CollectionViewManager {
    static let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseId)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
}

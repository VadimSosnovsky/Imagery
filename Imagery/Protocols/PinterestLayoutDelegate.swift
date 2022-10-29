//
//  PinterestLayoutDelegate.swift
//  Imagery
//
//  Created by Вадим Сосновский on 29.10.2022.
//

import UIKit

protocol PinterestLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat
}

//
//  CollectionViewCellViewModel.swift
//  Imagery
//
//  Created by Вадим Сосновский on 28.10.2022.
//

import UIKit

final class CollectionViewCellViewModel {
    
    var networkService = NetworkService.shared
    var completion: () -> () = {}
 
    func loadImages(from imagesInfoArray: [Result], completion: @escaping ((UIImage) -> Void)) {
        for item in imagesInfoArray {
            networkService.loadImages(from: item.urls.regularUrl) { image in
                completion(image)
            }
        }
    }
    
    func tappedAtCell(withImage image: UIImage) {
        completion()
    }
}

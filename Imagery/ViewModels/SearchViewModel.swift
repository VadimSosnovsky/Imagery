//
//  SearchViewModel.swift
//  Imagery
//
//  Created by Вадим Сосновский on 25.10.2022.
//

import Foundation
import UIKit

final class SearchViewModel {
    
    var timer: Timer?
    var networService = NetworkService.shared
    weak var coordinator: SearchCoordinator?
    var selectedImage: UIImage?
    
    func searchImages(with searchText: String, completion: @escaping ([Result]) -> Void) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [weak self] (_) in
            self?.networService.fetchImages(searchText: searchText) { (imageInfo) in
                if let imageInfo = imageInfo {
                    completion(imageInfo.results)
                }
            }
        })
    }
    
    func didSelectItem() {
        guard let selectedImage = selectedImage else { return }
        coordinator?.startAddScene(withImage: selectedImage)
    }
}

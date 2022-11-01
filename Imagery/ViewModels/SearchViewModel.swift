//
//  SearchViewModel.swift
//  Imagery
//
//  Created by Вадим Сосновский on 25.10.2022.
//

import Foundation

final class SearchViewModel {
    
    var timer: Timer?
    var networService = NetworkService.shared
    var coordinator: SearchCoordinator?
    
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
    
    func tappedAtCell() {
        print("tappedAtCell ------------>")
        coordinator?.startDetailScene()
    }
}

//
//  DetailViewModel.swift
//  Imagery
//
//  Created by Вадим Сосновский on 31.10.2022.
//

import Foundation
import UIKit

final class DetailViewModel {
    
    var coordinator: DetailCoordinator?
    var selectedImage: UIImage
    
    init(selectedImage: UIImage = UIImage()) {
        self.selectedImage = selectedImage
    }
    
    func saveImageButtonTapped() {
        let image = self.selectedImage
        let imageData = image.jpegData(compressionQuality: 1)
        let shared = RealmService.shared
        
        guard let imageData = imageData else { return }
        shared.addDataToDatabase(data: imageData)
        coordinator?.didFinishDetailScene()
    }
    
    func backButtonTapped() {
        coordinator?.didFinishDetailScene()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
}



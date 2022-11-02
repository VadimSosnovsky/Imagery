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
    
    init(selectedImage: UIImage) {
        self.selectedImage = selectedImage
    }
    
    func saveImageButtonTapped() {
        
    }
    
    func backButtonTapped() {
        coordinator?.didFinishDetailScene()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
}



//
//  AddViewModel.swift
//  Imagery
//
//  Created by Вадим Сосновский on 31.10.2022.
//

import Foundation
import UIKit

final class AddViewModel {
    
    var coordinator: AddCoordinator?
    var selectedImage: UIImage
    
    init(selectedImage: UIImage = UIImage()) {
        self.selectedImage = selectedImage
    }
    
    func saveImageButtonTapped() {
        let image = self.selectedImage
        let imageData = image.pngData()
        let shared = RealmService.shared
        
        guard let imageData = imageData else { return }
        shared.addDataToDatabase(data: imageData)
        coordinator?.didFinishAddScene()
    }
    
    func backButtonTapped() {
        coordinator?.didFinishAddScene()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
}



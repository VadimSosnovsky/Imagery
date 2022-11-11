//
//  RemoveViewModel.swift
//  Imagery
//
//  Created by Вадим Сосновский on 09.11.2022.
//

import Foundation
import UIKit
import RealmSwift

final class RemoveViewModel {
    
    var coordinator: RemoveCoordinator?
    var selectedImage: UIImage
    
    init(selectedImage: UIImage = UIImage()) {
        self.selectedImage = selectedImage
    }
    
    func removeImageButtonTapped() {
        let image = self.selectedImage
        let imageData = image.pngData()
        let shared = RealmService.shared
        
        let resultToDelete = shared.getDataFromDatabase().filter { $0.image == imageData }

        shared.removeDataFromDatabase(data: resultToDelete)
        coordinator?.didFinishRemoveScene()
    }
    
    func backButtonTapped() {
        coordinator?.didFinishRemoveScene()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
}

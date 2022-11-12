//
//  FavoriteViewModel.swift
//  Imagery
//
//  Created by Вадим Сосновский on 25.10.2022.
//

import Foundation
import FirebaseAuth

final class FavoriteViewModel {
    
    weak var coordinator: FavoriteCoordinator?
    var selectedImage: UIImage?
    let shared = RealmService.shared

    func getImages() -> [UIImage] {
        let results = shared.getDataFromDatabase()
        let images = Array(results)
        var arrayOfImage = [UIImage]()
        
        for imageRealm in images {
            let data = imageRealm.image
            let image = UIImage(data: data)
            guard let image = image else { return [] }
            arrayOfImage.append(image)
        }
        
        return arrayOfImage
    }
    
    func logoutButtonTapped() {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            coordinator?.logout()
        } catch let signOutError {
            print(signOutError)
        }
    }
    
    func didSelectItem() {
        guard let selectedImage = selectedImage else { return }
        coordinator?.startRemoveScene(withImage: selectedImage)
    }
}

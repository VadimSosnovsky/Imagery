//
//  RealmService.swift
//  Imagery
//
//  Created by Вадим Сосновский on 02.11.2022.
//

import Foundation
import RealmSwift

class RealmService: RealmProtocol {
    
    private init() {}
    static let shared = RealmService()
    var completion: () -> () = {}
    
    var userKey: String!
    var realm: Realm! {
        let path = Realm.Configuration().fileURL!.deletingLastPathComponent().appendingPathComponent("\(userKey!).realm")
        let realm = try! Realm(configuration: Realm.Configuration.init(fileURL: path))
        return realm
    }
    
    func createDatabaseIfNeeded(withComponent component: String) {
        let flag = FileControlManager().isFileExist(withComponent: component)
        if !flag {
            _ = RealmService.shared.realm!
        }
    }
    
    func addDataToDatabase(data: Data) {
        try! realm.write {
            let modelData = ImageRealm(image: data)
            realm.add(modelData)
            completion()
        }
    }
    
    func getDataFromDatabase() -> Results<ImageRealm> {
        let images = realm.objects(ImageRealm.self)
        return images
    }
    
    func removeDataFromDatabase() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}

//
//  RealmProtocol.swift
//  Imagery
//
//  Created by Вадим Сосновский on 03.11.2022.
//

import Foundation
import RealmSwift

protocol RealmProtocol {
    func createDatabaseIfNeeded(withComponent component: String)
    func addDataToDatabase(data: Data)
    func getDataFromDatabase() -> Results<ImageRealm>
    func removeDataFromDatabase()
    
    var userKey: String! { get }
    var realm: Realm! { get }
    var completion: () -> () { get }
}

//
//  ImageRealm.swift
//  Imagery
//
//  Created by Вадим Сосновский on 02.11.2022.
//

import Foundation
import RealmSwift

class ImageRealm: Object {
   @Persisted(primaryKey: true) var _id: ObjectId
   @Persisted var image: Data
    
   convenience init(image: Data) {
       self.init()
       self.image = image
   }
}

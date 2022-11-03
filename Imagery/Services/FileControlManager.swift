//
//  FileControlManager.swift
//  Imagery
//
//  Created by Вадим Сосновский on 03.11.2022.
//

import Foundation

class FileControlManager {
    func isFileExist(withComponent component: String) -> Bool {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(component) {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                return true
            }
        }
        return false
    }
}

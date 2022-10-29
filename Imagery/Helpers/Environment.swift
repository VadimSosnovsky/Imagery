//
//  Environment.swift
//  Imagery
//
//  Created by Вадим Сосновский on 26.10.2022.
//

import Foundation

public enum Environment {
    enum Keys {
        static let accessKey = "ACCESS_KEY"
        static let baseUrl = "BASE_URL"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        return dict
    }()
    
    static let baseURL: String = {
        guard let baseURLString = Environment.infoDictionary[Keys.baseUrl] as? String else {
            fatalError("Base URL not set in plist")
        }
        
        return baseURLString
    }()
    
    static let accessKey: String = {
        guard let accessKeyString = Environment.infoDictionary[Keys.accessKey] as? String else {
            fatalError("Access Key not set in plist")
        }
        return accessKeyString
    }()
}

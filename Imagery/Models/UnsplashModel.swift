//
//  UnsplashModel.swift
//  Imagery
//
//  Created by Вадим Сосновский on 26.10.2022.
//

import UIKit

struct ImageInfo: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let urls: Urls
}

struct Urls: Decodable {
    let regular: String
    var regularUrl: URL {
        return URL(string: regular)!
    }
}

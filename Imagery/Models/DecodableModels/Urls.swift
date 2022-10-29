//
//  Urls.swift
//  Imagery
//
//  Created by Вадим Сосновский on 27.10.2022.
//

import Foundation

struct Urls: Decodable {
    let regular: String
    var regularUrl: URL {
        return URL(string: regular)!
    }
}

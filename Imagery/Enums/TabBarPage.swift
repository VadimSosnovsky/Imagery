//
//  TabBarPage.swift
//  Imagery
//
//  Created by Вадим Сосновский on 25.10.2022.
//

import UIKit

enum TabBarPage: String {
    case search
    case favorite
    
    func pageTitleValue() -> String {
        switch self {
        case .search:
            return "Search"
        case .favorite:
            return "Favorite"
        }
    }
    
    func pageImageValue() -> UIImage {
        switch self {
        case .search:
            return UIImage(named: TabBarPage.search.rawValue) ?? UIImage()
        case .favorite:
            return UIImage(named: TabBarPage.favorite.rawValue) ?? UIImage()
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .search:
            return 0
        case .favorite:
            return 1
        }
    }
}

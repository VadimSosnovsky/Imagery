//
//  UIButton + Extensions.swift
//  Imagery
//
//  Created by Вадим Сосновский on 21.10.2022.
//

import UIKit

extension UIButton {
    
    convenience init(title: String) {
        self.init(type: .system)
        
        backgroundColor = .mainWhite()
        setTitle(title, for: .normal)
        tintColor = .mainDark()
        layer.cornerRadius = 10
        titleLabel?.font = .helveticaNeueBold20()
    }
}

//
//  AuthTextField.swift
//  Imagery
//
//  Created by Вадим Сосновский on 21.10.2022.
//

import UIKit

class AuthTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(placeholder: String, leftImageName: String? = nil, isButtonNeed: Bool = false) {
        self.init()
        self.placeholder = placeholder
        borderStyle = .roundedRect
        alpha = 0.9
        font = .helveticaNeueLight24()
        textColor = .mainDark()
        
        if let leftImageName = leftImageName {
            let Image = UIImage(named: leftImageName)
            let ImageView = UIImageView(image: Image)
            let color: UIColor = .mainDark()
            ImageView.setupColor(color: color)
            
            leftView = ImageView
            leftView?.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            leftViewMode = .always
        }
        
        if isButtonNeed {
            let button = UIButton(type: .system)
            button.setImage(UIImage(named: "eye")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
            rightView = button
            rightView?.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            rightViewMode = .always
        }
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 12
        return rect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x += -12
        return rect
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

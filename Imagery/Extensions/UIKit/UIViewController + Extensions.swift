//
//  UIViewController + Extensions.swift
//  Imagery
//
//  Created by Вадим Сосновский on 24.10.2022.
//

import UIKit

extension UIViewController {
    func errorAlertController(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func setupTextField(textField: UITextField, label: UILabel, validtype: String.ValidTypes, validMessage: String, wrongMessage: String, string: String, range: NSRange) {
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        
        if result.isValid(validType: validtype) {
            label.text = validMessage
            label.textColor = .mainGreen()
        } else {
            label.text = wrongMessage
            label.textColor = .mainRed()
        }
    }
}

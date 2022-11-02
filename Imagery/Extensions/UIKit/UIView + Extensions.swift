//
//  UIView + Extensions.swift
//  Imagery
//
//  Created by Вадим Сосновский on 02.11.2022.
//

import UIKit

extension UIView {
    func setupCornerRadius(cornerRadii: CGSize, roundingCorners: UIRectCorner) {
        let path = UIBezierPath(roundedRect:self.bounds,
                                byRoundingCorners: roundingCorners,
                                cornerRadii: cornerRadii)

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}

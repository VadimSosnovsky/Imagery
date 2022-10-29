//
//  CollectionViewCell.swift
//  Imagery
//
//  Created by Вадим Сосновский on 26.10.2022.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "CollectionViewCell"
    
    private let imageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        imageView.layer.cornerRadius = 6
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure Cell
extension CollectionViewCell {
    func configure(with image: UIImage) {
        self.imageView.image = image
    }
}

// MARK: - Setup Views
extension CollectionViewCell {
    private func setupViews() {
        addSubview(imageView)
    }
}

// MARK: - Setup Constraints
extension CollectionViewCell {
    func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

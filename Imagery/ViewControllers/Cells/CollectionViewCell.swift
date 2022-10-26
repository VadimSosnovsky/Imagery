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
    var networkService = NetworkService.shared
    
    private let imageView = UIImageView(image: nil, contentMode: .scaleAspectFit)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        customizeElements()
        setupConstraints()
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
    func configure(with url: URL) {
        networkService.loadImages(from: url) { [weak self] image in
            self?.imageView.image = image
        }
    }
}

// MARK: - Setup Views
extension CollectionViewCell {
    
    private func setupViews() {
        addSubview(imageView)
    }
    
    func customizeElements() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
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

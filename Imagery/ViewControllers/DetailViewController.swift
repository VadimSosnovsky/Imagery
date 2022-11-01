//
//  DetailViewController.swift
//  Imagery
//
//  Created by Вадим Сосновский on 31.10.2022.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    private let imageView = UIImageView(image: UIImage(systemName: "circle"), contentMode: .scaleAspectFill)
    private let saveButton = UIButton(title: "Save image")
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        setupViews()
        setupConstraints()
    }
}

// MARK: - Setup Views
extension DetailViewController {
    private func setupViews() {
        view.addSubview(imageView)
        view.addSubview(saveButton)
    }
}

// MARK: - Setup Constraints
extension DetailViewController {
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

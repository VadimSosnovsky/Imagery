//
//  DetailViewController.swift
//  Imagery
//
//  Created by Вадим Сосновский on 31.10.2022.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
        
    private let imageView = UIImageView(image: UIImage(systemName: "circle"), contentMode: .scaleAspectFit)
    private let saveImageButton = UIButton(title: "Add to collection")
    private let backButton = UIButton()
    private var stackView = UIStackView()
    
    var viewModel: DetailViewModel!
    var searchVC = SearchViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainWhite()
        imageView.image = viewModel.selectedImage
        
        setupViews()
        setupConstraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        customizeElements()
    }
}

// MARK: - Setup Views
extension DetailViewController {
    private func setupViews() {
        stackView = UIStackView(arrangedSubviews: [imageView,
                                                   saveImageButton],
                                axis: .vertical,
                                spacing: 20,
                                distribution: .fillProportionally,
                                alignment: .fill)
        
        let image = UIImage(named: "back")
        backButton.setImage(image, for: .normal)
        
        view.addSubview(backButton)
        view.addSubview(stackView)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        saveImageButton.addTarget(self, action: #selector(saveImageButtonTapped), for: .touchUpInside)
    }
    
    private func customizeElements() {
        saveImageButton.layer.cornerRadius = 15
        imageView.roundCornersForAspectFit(radius: 15)
        stackView.backgroundColor = .mainDark()
        stackView.directionalLayoutMargins = Constants.stackViewEdgeInsets
        stackView.setupCornerRadius(cornerRadii: Constants.cornerRadii, roundingCorners: [.topLeft, .topRight])
    }
}

// MARK: - Setup IBActions
extension DetailViewController {
    @objc private func saveImageButtonTapped() {
        viewModel.saveImageButtonTapped()
    }
    
    @objc private func backButtonTapped() {
        viewModel.backButtonTapped()
    }
}

// MARK: - Setup Constraints
extension DetailViewController {
    private func setupConstraints() {
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.leading.equalToSuperview().offset(24)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(128)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        saveImageButton.snp.makeConstraints { make in
            make.height.equalTo(84)
        }
    }
}

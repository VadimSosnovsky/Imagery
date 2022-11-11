//
//  AddViewController.swift
//  Imagery
//
//  Created by Вадим Сосновский on 31.10.2022.
//

import UIKit
import SnapKit

class AddViewController: UIViewController {
        
    private let imageView = UIImageView(image: UIImage(systemName: "circle"), contentMode: .scaleAspectFit)
    private let saveImageButton = UIButton(title: "Add to collection")
    private let backButton = UIButton()
    private var stackView = UIStackView()
    
    var viewModel: AddViewModel!
    
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
    
    override func viewWillLayoutSubviews() {
        customizeElements()
    }
}

// MARK: - Setup Views
extension AddViewController {
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
        stackView.backgroundColor = .mainGray()
        stackView.directionalLayoutMargins = Constants.stackViewEdgeInsets
        stackView.setupCornerRadius(cornerRadii: Constants.cornerRadii, roundingCorners: [.topLeft, .topRight])
    }
}

// MARK: - Setup IBActions
extension AddViewController {
    @objc private func saveImageButtonTapped() {
        viewModel.saveImageButtonTapped()
    }
    
    @objc private func backButtonTapped() {
        viewModel.backButtonTapped()
    }
}

// MARK: - Setup Constraints
extension AddViewController {
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

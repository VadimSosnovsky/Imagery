//
//  RemoveViewController.swift
//  Imagery
//
//  Created by Вадим Сосновский on 09.11.2022.
//

import UIKit
import SnapKit

class RemoveViewController: UIViewController {
        
    private let imageView = UIImageView(image: UIImage(systemName: "circle"), contentMode: .scaleAspectFit)
    private let removeImageButton = UIButton(title: "Remove from collection")
    private let backButton = UIButton()
    private var stackView = UIStackView()
    
    var viewModel: RemoveViewModel!
    
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
extension RemoveViewController {
    private func setupViews() {
        stackView = UIStackView(arrangedSubviews: [imageView,
                                                   removeImageButton],
                                axis: .vertical,
                                spacing: 20,
                                distribution: .fillProportionally,
                                alignment: .fill)
        
        let image = UIImage(named: "back")
        backButton.setImage(image, for: .normal)
        
        view.addSubview(backButton)
        view.addSubview(stackView)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        removeImageButton.addTarget(self, action: #selector(removeImageButtonTapped), for: .touchUpInside)
    }
    
    private func customizeElements() {
        removeImageButton.layer.cornerRadius = 15
        imageView.roundCornersForAspectFit(radius: 15)
        stackView.backgroundColor = .mainGray()
        stackView.directionalLayoutMargins = Constants.stackViewEdgeInsets
        stackView.setupCornerRadius(cornerRadii: Constants.cornerRadii, roundingCorners: [.topLeft, .topRight])
    }
}

// MARK: - Setup IBActions
extension RemoveViewController {
    @objc private func removeImageButtonTapped() {
        viewModel.removeImageButtonTapped()
    }
    
    @objc private func backButtonTapped() {
        viewModel.backButtonTapped()
    }
}

// MARK: - Setup Constraints
extension RemoveViewController {
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
        
        removeImageButton.snp.makeConstraints { make in
            make.height.equalTo(84)
        }
    }
}

//
//  FavoriteViewController.swift
//  Imagery
//
//  Created by Вадим Сосновский on 25.10.2022.
//

import UIKit
import SnapKit
import RealmSwift
import FirebaseAuth

class FavoriteViewController: UIViewController {
    
    var collectionViewManager: CollectionViewManager!
    lazy var collectionView = collectionViewManager.collectionView
    
    let shared = RealmService.shared
    
    var viewModel: FavoriteViewModel!
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainWhite()
        
        collectionViewManager = CollectionViewManager()
        collectionViewManager.viewModel = CollectionViewCellViewModel()
        
        collectionViewManager.completion = { [weak self] image in
            self?.viewModel.selectedImage = image
            self?.viewModel.didSelectItem()
        }
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
        
        self.collectionViewManager.images = viewModel.getImages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.collectionViewManager.images = self.viewModel.getImages()
        self.collectionView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("FavoriteViewController disappeared ----->")
    }
    
    deinit {
        print("FavoriteViewController deinit ----->")
    }
}

// MARK: - Setup Views
extension FavoriteViewController {
    private func setupViews() {
        view.addSubview(collectionView)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favorite"
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.mainDark()]
        
        let logoutButton = UIBarButtonItem(image: UIImage(named: "logout")?.withRenderingMode(.alwaysOriginal),
                                           style: .plain ,
                                           target: self,
                                           action: #selector(logoutButtonTapped))
        navigationItem.rightBarButtonItem = logoutButton
    }
}

// MARK: - Setup IBActions
extension FavoriteViewController {
    @objc private func logoutButtonTapped() {
        viewModel.logoutButtonTapped()
    }
}

// MARK: - Setup Constraints
extension FavoriteViewController {
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}

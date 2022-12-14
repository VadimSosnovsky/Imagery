//
//  SearchViewController.swift
//  Imagery
//
//  Created by Вадим Сосновский on 25.10.2022.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    var collectionViewManager: CollectionViewManager!
    lazy var collectionView = collectionViewManager.collectionView
    let activityIndicator = UIActivityIndicatorView()
    private let searchLabel = UILabel(font: .helveticaNeueBold20(), textColor: .mainDark())
    var pictureInfo = [Result]()
    var passImage: (UIImage) -> Void = { _ in }
    
    let searchViewController = UISearchController(searchResultsController: nil)
    var viewModel: SearchViewModel!
    var networService = NetworkService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainWhite()
        
        collectionViewManager = CollectionViewManager()
        collectionViewManager.viewModel = CollectionViewCellViewModel()
        
        collectionViewManager.onUpdate = { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
        
        collectionViewManager.completion = { [weak self] image in
            self?.viewModel.selectedImage = image
            self?.viewModel.didSelectItem()
        }
        
        setupNavigationBar()
        setupViews()
        setupConstraints()
        setupDelegates()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchViewController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Setup Views
extension SearchViewController {
    private func setupViews() {
        searchLabel.text = "Let's search some images"
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        view.addSubview(searchLabel)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search"
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.mainDark()]
        navigationItem.searchController = searchViewController
    }
}

// MARK: - Setup Constraints
extension SearchViewController {
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        let views = [activityIndicator, searchLabel]
        for view in views {
            view.snp.makeConstraints { make in
                make.centerX.equalTo(collectionView.snp.centerX)
                make.centerY.equalTo(collectionView.snp.centerY)
            }
        }
    }
}

// MARK: - Setup Delegates
extension SearchViewController {
    private func setupDelegates() {
        searchViewController.searchBar.delegate = self
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchImages(with: searchText) { [weak self] result in
            self?.activityIndicator.startAnimating()
            self?.collectionViewManager.pictureInfo = result
            self?.searchLabel.isHidden = result.count > 0 ? true : false
        }
    }
}

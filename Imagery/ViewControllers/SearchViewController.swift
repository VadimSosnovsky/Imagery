//
//  SearchViewController.swift
//  Imagery
//
//  Created by Вадим Сосновский on 25.10.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let collectionView = CollectionViewManager.collectionView
    
    let searchViewController = UISearchController(searchResultsController: nil)
    var didSendEventClosure: ((SearchViewController.Event) -> Void)?
    var viewModel: SearchViewModel!
    var networService = NetworkService.shared
    var timer: Timer?
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupViews()
        customizeElements()
        setupConstraints()
        setupDelegates()
    }
    var pictureInfo = [Result]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: - Setup Views
extension SearchViewController {
    private func setupViews() {
        
        collectionView.backgroundColor = .systemGreen
        view.addSubview(collectionView)
    }
    
    private func customizeElements() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
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
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [weak self] (_) in
            self?.networService.fetchImages(searchText: searchText) { (imageInfo) in
                if let imageInfo = imageInfo {
                    self?.pictureInfo = imageInfo.results
                }
            }
        })
    }
}

// MARK: - TabBar Events setup
extension SearchViewController {
    enum Event {
        case search
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pictureInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: self.pictureInfo[indexPath.row].urls.regularUrl)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

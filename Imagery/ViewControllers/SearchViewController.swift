//
//  SearchViewController.swift
//  Imagery
//
//  Created by Вадим Сосновский on 25.10.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var didSendEventClosure: ((SearchViewController.Event) -> Void)?
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}

extension SearchViewController {
    enum Event {
        case search
    }
}

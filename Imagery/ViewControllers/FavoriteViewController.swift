//
//  FavoriteViewController.swift
//  Imagery
//
//  Created by Вадим Сосновский on 25.10.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var didSendEventClosure: ((FavoriteViewController.Event) -> Void)?
    var viewModel: FavoriteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}

extension FavoriteViewController {
    enum Event {
        case favorite
    }
}

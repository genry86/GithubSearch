//
//  ReactiveViewController.swift
//  GithubSearch
//
//  Created by Genry on 8/19/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation
import ReactiveCocoa

/**
 Base class with generic view model for all UI controllers
 */
class ReactiveViewController<T: ViewModelProtocol>: UIViewController {
    
    // MARK: -
    // MARK: Properties
    // MARK: -
    
    /**
     Connected view model to subclassed controller
     */
    let viewModel: T
    
    // MARK: -
    // MARK: Lifecycle
    // MARK: -
    
    init(viewModel: T, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(viewModel: T) {
        self.init(viewModel: viewModel, nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: API
    // MARK: -
    
    override func loadView() {
        super.loadView()
        // Flag which tells controller's view to be under bar
        self.navigationController?.navigationBar.isTranslucent = false;
    }
}

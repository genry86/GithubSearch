//
//  ReactiveTableViewCell.swift
//  GithubSearch
//
//  Created by Genry on 8/23/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result

/**
 Base class with generic view model for all UI cells
 */
class ReactiveTableViewCell<T: ViewModelProtocol>: UITableViewCell {
    
    // MARK: Properties
    
    /**
     view model signal used to update data in cell
     */
    var vm_signal: Signal<T, NoError> { return signal }
    
    /**
     Decomposed tuple to have observer object and send data to signal
     */
    private let (signal, observer) = Signal<T, NoError>.pipe()
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: API
    
    func bindViewModel(viewModel: T) {
        observer.send(value: viewModel)
        
        // Updating cell when new view model bound
        updateConstraintsIfNeeded()
        setNeedsLayout()
    }
    
    class func reuseIdentifier() -> String {
        return "com.genry.gitsearchcell"
    }
}

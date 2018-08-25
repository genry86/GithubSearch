//
//  ViewModel.swift
//  GithubSearch
//
//  Created by Genry on 8/19/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import Foundation

/**
 Base class for all view models
 */
class ViewModel: ViewModelProtocol {
    
    // MARK: -
    // MARK: Properties
    // MARK: -
    
    /**
     Main app services which stores all other specific services
     */
    let services: ViewModelServicesProtocol
    
    // MARK: -
    // MARK: Lifecycle
    // MARK: -
    
    init(services: ViewModelServicesProtocol) {
        self.services = services
    }
}

//
//  ViewModelServices.swift
//  GithubSearch
//
//  Created by Genry on 8/19/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import Foundation

/**
 Main service class used to store refs to specific services in app
 */
class ViewModelServices: ViewModelServicesProtocol {
    
    // MARK: -
    // MARK: Properties
    // MARK: -
    
    /**
     Specific repos service 
     */
    let repos: ReposServiceProtocol
    
    // MARK: -
    // MARK: Lifecycle
    // MARK: -
    
    init() {
        // Place where all possible specific services initialized
        self.repos = RepoService()
    }
 
}

//
//  ViewModelServicesProtocol.swift
//  GithubSearch
//
//  Created by Genry on 8/19/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import Foundation

/**
 Used to determine view model services protocol
 */
protocol ViewModelServicesProtocol {
    
    /**
     Requirement to have Repos' specific object
     */
    var repos: ReposServiceProtocol { get }
}

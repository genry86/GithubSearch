//
//  ViewModelServicesDelegate.swift
//  GithubSearch
//
//  Created by Genry on 8/23/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import Foundation

/**
 Protocol for holder of services
 */
protocol ViewModelServicesDelegate: class {
    
    /**
     Requirement to have services
     */
    var services: ViewModelServicesProtocol? { get }
}

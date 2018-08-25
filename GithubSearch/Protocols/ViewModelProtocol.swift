//
//  ViewModelProtocol.swift
//  GithubSearch
//
//  Created by Genry on 8/19/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import Foundation

/**
 Used to apply generic view models to UI controllers
 */
protocol ViewModelProtocol {
    
    // MARK: -
    // MARK: Properties
    // MARK: -
    
    var services: ViewModelServicesProtocol { get }
}

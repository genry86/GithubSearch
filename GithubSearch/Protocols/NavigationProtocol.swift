//
//  NavigationProtocol.swift
//  GithubSearch
//
//  Created by Genry on 8/24/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import Foundation

/**
 Protocol for main Navigation class to all app actions
 */
protocol NavigationProtocol: class {
    
    /**
     Requirement to have push function to do navigation
     */
    func push(viewModel: ViewModelProtocol)
}

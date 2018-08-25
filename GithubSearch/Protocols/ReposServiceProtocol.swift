//
//  RepoServiceProtocol.swift
//  GithubSearch
//
//  Created by Genry on 8/19/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

/**
 Specific Repos Protocol
 */
protocol ReposServiceProtocol {
    
    /**
     Requirement to have cache with repos
     */
    var cache: NSCache<NSString, NSArray> { get }
}

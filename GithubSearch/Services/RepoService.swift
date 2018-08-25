//
//  RepoService.swift
//  GithubSearch
//
//  Created by Genry on 8/19/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

/**
 Specific repo service to manage repos
 */
class RepoService: ReposServiceProtocol {
    
    // MARK: -
    // MARK: Properties
    // MARK: -
    
    /**
     Cache object to store temp resaults for specific number of searches. Used for better performance.
     */
    let cache = NSCache<NSString, NSArray>()
    
    // MARK: -
    // MARK: Lifecycle
    // MARK: -
    
    init() {
        // Set limit of storred objects in cache
        cache.countLimit = Constants.cacheSize
    }
}

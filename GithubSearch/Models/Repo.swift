//
//  Repo.swift
//  GithubSearch
//
//  Created by Genry on 8/19/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation

class Repo {

    // MARK: Properties
    
    let avatarUrl: String
    var avatar: UIImage?
    let name: String
    let forks: Int
    let stars: Int
    let owner: String
    let desc: String?
    var readme: String?
    
    // MARK: Lifecycle
    
    init(avatarUrl: String, name: String, forks: Int, stars: Int, owner: String, desc: String?) {
        self.name = name
        self.avatarUrl = avatarUrl
        self.forks = forks
        self.stars = stars
        self.owner = owner
        self.desc = desc
    }
    
    // MARK: API
    
    static func deserialize(dictionary: Dictionary<String, Any>) -> Repo {
        let name = dictionary["name"] as! String
        let desc = dictionary["description"] as? String
        let forks = dictionary["forks"] as! Int
        let stars = dictionary["stargazers_count"] as! Int
        
        let owner = dictionary["owner"] as! Dictionary<String, Any>
        let avatarUrl = owner["avatar_url"] as! String
        let ownerLogin = owner["login"] as! String
        
        return Repo(avatarUrl: avatarUrl, name: name, forks: forks, stars: stars, owner: ownerLogin, desc: desc)
    }
}

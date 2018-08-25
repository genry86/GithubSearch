//
//  DetailsViewModel.swift
//  GithubSearch
//
//  Created by Genry on 8/19/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation
import ReactiveSwift
import ReactiveCocoa

/**
 Details viewmodel
 */
class DetailsViewModel: ViewModel {
    
    // MARK: -
    // MARK: Properties
    // MARK: -
    
    /**
     Holder of repo object to observe
     */
    private let repo: MutableProperty<Repo>
    
    var name = MutableProperty<String>("")
    var desc = MutableProperty<String?>("")
    var avatar = MutableProperty<UIImage?>(nil)
    var owner = MutableProperty<String>("")
    var forks = MutableProperty<Int>(0)
    var stars = MutableProperty<Int>(0)
    var readme = MutableProperty<String?>("")

    // MARK: -
    // MARK: Lifecycle
    // MARK: -
    
    init(services: ViewModelServicesProtocol, repo: Repo) {
        self.repo = MutableProperty(repo)
        
        super.init(services: services)

        // Bind repo's properties to viewmodel properties
        self.name <~ self.repo.map { $0.name }
        self.desc <~ self.repo.map { $0.desc }
        self.owner <~ self.repo.map { $0.owner }
        self.forks <~ self.repo.map { $0.forks }
        self.stars <~ self.repo.map { $0.stars }
        
        // Chceking whether avatar image exists. if not fetching it.
        if repo.avatar == nil {
            self.fetchAvatar(repo: repo) {
                repo.avatar = $0
                self.avatar.value = $0
            }
        }
        
        // Chceking whether readme exists. if not fetching it.
        if repo.readme == nil {
            fetchReadMe(repo: repo) {
                repo.readme = $0
                self.readme.value = $0
            }
        }
    }
    
    // MARK: -
    // MARK: Private
    // MARK: -
    
    /**
     Fetching owner's avatar when repo details screen openned
     */
    private func fetchAvatar(repo: Repo, completion: @escaping (UIImage) -> Void){
        DispatchQueue.global(qos: .background).async {
            
            // Getting avatar image from netwok
            if let url = URL(string: repo.avatarUrl),
               let imageData = try? Data(contentsOf: url),
               let avatar = UIImage(data: imageData) {
                
                repo.avatar = avatar
                DispatchQueue.main.async {
                    completion(repo.avatar!)
                }
            }
        }
    }
    
    /**
     Fetching repo's readme when repo details screen openned
     */
    private func fetchReadMe(repo: Repo, completion: @escaping (String?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            
            // Clean up readme string from <> [] () tags
            repo.readme = String.cleanText(htmlPageUrl: String(format: Constants.Urls.Readme, repo.owner, repo.name))
            DispatchQueue.main.async {
                completion(repo.readme)
            }
        }
    }
}

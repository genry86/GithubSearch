//
//  RepoCellViewModel.swift
//  GithubSearch
//
//  Created by Genry on 8/23/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift

/**
 Repo cell
 */
class RepoCellViewModel: ViewModel {
    
    // MARK: -
    // MARK: Properties
    // MARK: -
    
    /**
     Holder of repo property to observe
     */
    let repo: MutableProperty<Repo>
    
    /**
     Name of repo
     */
    var name = MutableProperty<String>("")
    /**
     Stars of repo
     */
    var stars = MutableProperty<Int>(0)
    /**
     Description of repo
     */
    var desc = MutableProperty<String?>("")
    
    // MARK: -
    // MARK: Lifecycle
    // MARK: -
    
    init(services: ViewModelServicesProtocol, repo: Repo) {
        self.repo = MutableProperty(repo)
        
        super.init(services: services)

        // Bind of repo properties to viewmodel's properties
        self.name <~ self.repo.map { $0.name }
        self.stars <~ self.repo.map { $0.stars }
        self.desc <~ self.repo.map { $0.desc }
    }
}

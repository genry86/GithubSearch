//
//  ReposViewModel.swift
//  GithubSearch
//
//  Created by Genry on 8/19/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation
import ReactiveSwift
import Result

/**
 Repos view model
 */
class ReposViewModel: ViewModel {
    
    // MARK: -
    // MARK: Properties
    // MARK: -
    
    /**
     Navigation object to show new screen with details
     */
    private let navigation: NavigationProtocol
    
    /**
     Holder of search string and trigger search network requests
     */
    var searchString = MutableProperty<String?>("")
    
    /**
     Holder of repos' viewmodels
     */
    var repos = MutableProperty<[RepoCellViewModel]>([])
    
    /**
     Action triggered from controller to present repo details
     */
    var showDetails: Action<(Int), (), NoError>? = nil
    /**
     Action triggered from controller to clean up search results
     */
    var cancel: Action<(), (), NoError>? = nil

    // MARK: -
    // MARK: Lifecycle
    // MARK: -
    
    init(services: ViewModelServicesProtocol, navigation: NavigationProtocol) {
        self.navigation = navigation
        
        super.init(services: services)
   
        // Present repo details action.
        showDetails = Action { [unowned self] repoIndex -> SignalProducer<(), NoError> in
            // Getting repo
            let repo = self.repos.value[repoIndex].repo
            // Creating viewmodel based on repo
            let detailsViewMode = DetailsViewModel(services: services, repo: repo.value)
            
            // Presenting Details screen
            navigation.push(viewModel: detailsViewMode)
            return SignalProducer(value: ())
        }
        
        // Clean up search results
        cancel = Action { [unowned self] in
            // clean up repos list
            self.repos.value.removeAll()
            return SignalProducer(value: ())
        }
        
        // Core search string observing. Making requests. Mapping received data to repos list.
        searchString.signal
            .flatMap(.latest) { [unowned self] (query: String?) -> SignalProducer<(Data, URLResponse), AnyError> in
                
                // Getting cached objects at first to fill repos list
                if let cachedItems = self.services.repos.cache.object(forKey: query! as NSString) as? [RepoCellViewModel] {
                    self.repos.value = cachedItems
                }
                
                // making search network request
                return self.makeSearchRequest(fromQuery: query!)
            }
            .map { [unowned self] (data, response) -> [RepoCellViewModel] in
                // Mapping search result to list of repos
                return self.searchResults(fromData: data)
            }
            .observe(on: UIScheduler())
            .observeResult { [unowned self] repos in
                // Saving received data local repos field
                self.repos.value.append(contentsOf: repos.value!)
                // Saving received data to cache
                services.repos.cache.setObject(self.repos.value as NSArray, forKey: self.searchString.value! as NSString)
            }
    }
    
    // MARK: -
    // MARK: Private
    // MARK: -
    
    /**
     Calculates next page number to fetch new repos
     */
    private func nextPageNumber() -> Int {
        return Int((Double(repos.value.count + 1) / Double(Constants.ReposList.PageSize)).rounded(.up))
    }
    
    private func makeSearchRequest(fromQuery searchQuery: String) -> SignalProducer<(Data, URLResponse), AnyError> {
        // Creating cearch request
        if let request = URLRequest.request(urlString: String(format: Constants.Urls.Repos, searchQuery, nextPageNumber(),
                                                              Constants.ReposList.PageSize)) {
            // Triggering request
            return URLSession.shared.reactive.data(with: request)
        }
        return SignalProducer<(Data, URLResponse), AnyError>(value: (Data(), URLResponse()))
    }
    
    private func searchResults(fromData data: Data) -> [RepoCellViewModel] {
        var repos = [RepoCellViewModel]()

        // Getting string from received data
        if let jsonString = data.string(),
            // Getting json dictionary from string
            let json = jsonString.json(),
            // Getting items from json
            let items = json["items"] as? Array<Dictionary<String, Any>> {

            // Creation of repo, repo-viewmodel objects and saving them to repos field
            for item in items {
                let repo = Repo.deserialize(dictionary: item)
                let repoCell = RepoCellViewModel(services: services, repo: repo)
                repos.append(repoCell)
            }
        }

        return repos
    }
}

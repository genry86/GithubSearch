//
//  DetailsViewController.swift
//  GithubSearch
//
//  Created by Genry on 8/19/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation
import UIColor_Hex_Swift
import ionicons
import BadgeSegmentControl
import ReactiveSwift
import ReactiveCocoa

/**
 UI View Controller which present and manage data for Detailed Repo info
 */
class DetailsViewController: ReactiveViewController<DetailsViewModel> {
    
    // MARK: -
    // MARK: Properties
    // MARK: -
    
    /**
     Main View of controller with all elements
     */
    private let detailsView = DetailsView(frame: CGRect.zero)
    
    // MARK: -
    // MARK: Lifecycle
    // MARK: -
    
    init(viewModel: DetailsViewModel) {
        super.init(viewModel: viewModel, nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting up custom view as main one
        self.view = detailsView
        // Title of screen is set to Repo name
        title = viewModel.name.value
        
        // Fill in Segment items
        detailsView.gitSegmentControl.setupSegmentItems(stars: viewModel.stars.value, forks: viewModel.forks.value)
        
        // Magic binding of ViewModel properties to View elements
        detailsView.userLoginLabel.reactive.text <~ viewModel.owner
        detailsView.descriptionTextView.reactive.text <~ viewModel.desc
        detailsView.readmeTextView.reactive.text <~ viewModel.readme
        
        // Animating load indicator if avatar is empty
        if viewModel.avatar.value == nil {
            detailsView.avatarIndicator.startAnimating()
        }
        // Once avatar loaded, animation of load indicator stopped
        self.viewModel.avatar.signal.observeValues { [unowned self] avatar in
            self.detailsView.avatarView.image = avatar
            self.detailsView.avatarIndicator.stopAnimating()
        }
        
        // Animating load indicator if readme is empty
        if viewModel.readme.value == nil {
            detailsView.readmeIndicator.startAnimating()
        }
        // Once readme loaded, animation of load indicator stopped
        viewModel.readme.signal.observeValues { [unowned self] _ in
            self.detailsView.readmeIndicator.stopAnimating() }
    }
}

//
//  ReposViewController.swift
//  GithubSearch
//
//  Created by Genry on 8/19/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation
import ReactiveCocoa
import ReactiveSwift
import SnapKit

/**
 Main Screen Controller with listed repos
 */
class ReposViewController: ReactiveViewController<ReposViewModel>, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // MARK: -
    // MARK: Properties
    // MARK: -
    
    /**
      Main Table List Control with Repos
     */
    private var reposTableView: UITableView!
    /**
     Search control for typing filter string
     */
    private var searchBar: UISearchBar!
    
    /**
     Boolean flag to set elements constraints only once
     */
    private var didSetupConstraints = false
    /**
     Boolean flag to prevent constant loading-more operation. New request done after previous one is finished
     */
    private var isLoading = false
    
    // MARK: -
    // MARK: Lifecycle
    // MARK: -
    
    init(viewModel: ReposViewModel) {
        super.init(viewModel: viewModel, nibName: nil, bundle: nil)
        
        searchBar = UISearchBar(delegate: self)
        reposTableView = UITableView(delegate: self, cellClass: RepoTableViewCell.self, cellIdntifier: RepoTableViewCell.reuseIdentifier())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        // Adding views to parent view
        view.addSubview(searchBar)
        view.addSubview(reposTableView)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Setup constraints
        if !didSetupConstraints {
            
            // Search bar constraints
            searchBar.snp.makeConstraints { make in
                make.top.equalTo(self.view.snp.top)
                make.left.equalTo(self.view.snp.left)
                make.right.equalTo(self.view.snp.right)
                make.height.equalTo(Constants.ReposList.Search.BarHeight)
            }
            
            // Table list constraint
            reposTableView.snp.makeConstraints { make in
                make.top.equalTo(self.searchBar.snp.bottom)
                make.left.equalTo(self.view.snp.left)
                make.right.equalTo(self.view.snp.right)
                make.bottom.equalTo(self.view.snp.bottom)
            }
            didSetupConstraints = true
        }
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting localized title if exists
        title = "Github Trends".localized()
        
        // Core Binding of search string to view model and triggering whole workflow
        self.viewModel.searchString <~ self.searchBar.reactive.continuousTextValues
                                            // Decline search string less than specified
                                           .filter { ($0?.count)! >= Constants.ReposList.countOfSymbolsToDoSearch }
                                            // Limits requests in time with interval
                                           .throttle(Constants.ReposList.Search.RequestsInterval, on: QueueScheduler.main)
        
        // Reload table when network git repos received and handled
        self.viewModel.repos.signal.observeResult { [unowned self] _ in
            self.reposTableView.reloadData()
            self.isLoading = false
        }
    }
    
    // MARK: -
    // MARK: UITableViewDataSource
    // MARK: -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.repos.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.reuseIdentifier()) as! ReactiveTableViewCell<RepoCellViewModel>
        
        // Fetching specific Cell viewmodel
        let vm = viewModel.repos.value[indexPath.row]
        // Bind viewmodel to scpecific cell
        cell.bindViewModel(viewModel: vm)
        
        // Load mode operation triggered if last row reached
        if indexPath.row == self.viewModel.repos.value.count - 1, !self.isLoading {
            loadMore()
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.ReposList.CellHeight;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Presend details of repo
        viewModel.showDetails?.apply(indexPath.row).start()
    }
    
    // MARK: -
    // MARK: Private
    // MARK: -
    
    private func loadMore() {
        // Initiating additional signal request
        self.viewModel.searchString.value = self.searchBar.text
        // Setting flag to prohibit requests if one is executing already
        self.isLoading = true
    }
    
    // MARK: -
    // MARK: UISearchBarDelegate
    // MARK: -
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // clean result if number of chars in search bar is less than specified
        if searchText.count < Constants.ReposList.countOfSymbolsToDoSearch {
            viewModel.cancel?.apply().start()
        }
    }
}

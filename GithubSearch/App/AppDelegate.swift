//
//  AppDelegate.swift
//  GithubSearch
//
//  Created by Genry on 8/25/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // Navigation property to be able to show Repo's details
    var navigationController: UINavigationController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Root repos ViewModel initialized with global services and navigation
        let reposViewModel = ReposViewModel(services: ViewModelServices(), navigation: Navigation())
        
        let rootViewController = ReposViewController(viewModel: reposViewModel)
        navigationController = UINavigationController(rootViewController: rootViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        return true
    }
}


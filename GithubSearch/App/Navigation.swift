//
//  Navigation.swift
//  GitSearch
//
//  Created by Genry on 8/24/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation

/**
 Encapsulating of navigation logic used in Viewmodel's
 */
class Navigation: NavigationProtocol {
    /**
     Push new UIViewController based on type of ViewModel
     - parameters:
        - viewModel: which will determine what Controller would be pushed
     - note:
        Only one case declareted. But in real project will more
     */
    func push(viewModel: ViewModelProtocol) {
        switch viewModel {
            case let detaisViewModel as DetailsViewModel:
                // Creation of Details view controller based on view model
                let detailsViewController = DetailsViewController(viewModel: detaisViewModel)
                
                // Getting top Navigation controller
                let navigationController = (UIApplication.shared.delegate as! AppDelegate).navigationController
                
                // Navigation to new controller
                navigationController?.pushViewController(detailsViewController, animated: true)
            default:
                print("something else")
        }
    }
}

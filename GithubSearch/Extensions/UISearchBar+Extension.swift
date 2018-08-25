//
//  UISearchBar+Extension.swift
//  GithubSearch
//
//  Created by Genry on 8/24/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation

extension UISearchBar {
    /**
     Initialize new UISearchBar object with its delegate
     */
    convenience init(delegate: AnyObject) {
        self.init(frame: CGRect.zero)
        self.delegate = delegate as? UISearchBarDelegate
    }
}

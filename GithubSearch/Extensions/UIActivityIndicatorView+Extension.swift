//
//  UIActivityIndicatorView+Extension.swift
//  GithubSearch
//
//  Created by Genry on 8/24/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation

extension UIActivityIndicatorView {
    /**
     Initialize new UIActivityIndicatorView object with parent view and with Style
     */
    convenience init(superView: UIView, style: UIActivityIndicatorViewStyle) {
        self.init(activityIndicatorStyle: style)
        superView.addSubview(self)
    }
}

//
//  UIView+Extension.swift
//  GithubSearch
//
//  Created by Genry on 8/24/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    /**
     Initialize new UIView object with parent view and background
     */
    convenience init(superView: UIView, backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
        superView.addSubview(self)
    }
}

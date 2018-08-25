//
//  UIImageView+Extension.swift
//  GithubSearch
//
//  Created by Genry on 8/24/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation
import ionicons

extension UIImageView {
    /**
     Initialize new UIImageView object with parent view
     */
    convenience init(superView: UIView) {
        self.init()
        self.layer.cornerRadius = Constants.RepoDetails.Border.Radius
        superView.addSubview(self)
    }
    
    /**
     Initialize new UIImageView object with parent view and with icon name/size
     */
    convenience init(superView: UIView, iconName: String, size: CGFloat) {
        self.init(superView: superView)
        self.image = IonIcons.image(withIcon: iconName, size: size, color: Constants.Color.Text.Main)
    }
}

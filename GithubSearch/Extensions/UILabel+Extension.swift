//
//  UILabel+Extension.swift
//  GithubSearch
//
//  Created by Genry on 8/24/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation

extension UILabel {
    /**
     Initialize new UILabel object with parent view
     */
    convenience init(superView: UIView) {
        self.init()
        superView.addSubview(self)
    }
    
    /**
     Initialize new UILabel object with parent view and text color
     */
    convenience init(superView: UIView, textColor: UIColor) {
        self.init(superView: superView)
        self.textColor = textColor
    }
    
    /**
     Initialize new UILabel object with parent view, text color and font
     */
    convenience init(superView: UIView, font: UIFont, textColor: UIColor) {
        self.init(superView: superView, textColor: textColor)
        self.font = font
    }
}

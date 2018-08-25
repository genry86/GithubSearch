//
//  UITextView+Extension.swift
//  GithubSearch
//
//  Created by Genry on 8/24/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation

extension UITextView {
    /**
     Initialize new UITextView object with parent view, text/background colors
     */
    convenience init(superView: UIView, textColor: UIColor, font: UIFont, backgroundColor: UIColor = UIColor.white, alignment: NSTextAlignment = .justified) {
        self.init()
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.font = font
        self.textAlignment = alignment
        self.isEditable = false
        superView.addSubview(self)
    }
}

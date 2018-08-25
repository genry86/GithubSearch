//
//  UITableView+Extension.swift
//  GithubSearch
//
//  Created by Genry on 8/24/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation

extension UITableView {
    /**
     Initialize new UITableView object with delegate and cell's class/identifier
     - parameters:
        - delegate: responder for table data
        - cellClass: Cell class
        - cellIdntifier: Cell identifier
     */
    convenience init(delegate: AnyObject, cellClass: AnyClass, cellIdntifier: String) {
        self.init(frame: CGRect.zero, style: .plain)
        self.rowHeight = UITableViewAutomaticDimension
        self.dataSource = delegate as? UITableViewDataSource
        self.delegate = delegate as? UITableViewDelegate
        self.register(cellClass, forCellReuseIdentifier: cellIdntifier)
    }
}

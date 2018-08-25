//
//  Data+Extension.swift
//  GithubSearch
//
//  Created by Genry on 8/24/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import Foundation

extension Data {
    /**
     Converting Data to string if possible
     - returns:
        String or nil if failed
     */
    func string() -> String? {
        return String(data: self, encoding: .utf8)
    }
}

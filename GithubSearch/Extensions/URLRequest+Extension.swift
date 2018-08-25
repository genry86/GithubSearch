//
//  URLRequest+Extension.swift
//  GithubSearch
//
//  Created by Genry on 8/24/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation

extension URLRequest {
    /**
     Initialize new URLRequest object from url-string
     - parameters:
        - urlString: url string
     - returns:
        - new URLRequest object or nil if failed
     */
    static func request(urlString: String) -> URLRequest? {
        // Creation of URL
        if let url = URL(string: urlString) {
            // Creation of URLRequest
            var request = URLRequest(url: url)
            // Setting up http method
            request.httpMethod = "GET"
            return request
        }
        
        return nil
    }
}

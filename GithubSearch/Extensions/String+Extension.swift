//
//  StringExtension.swift
//  GithubSearch
//
//  Created by Genry on 8/22/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation

extension String {
    /**
     Simple string localization extension method
     */
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    /**
     Converting string to Dictionary, as json or return nil if failed
     */
    func json() -> [String: Any]? {
        // Getting UTF8 Data from string
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                // Serializing Data to Dictionary
                return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
            } catch {
                print("json string converting to json dictionary failed")
            }
        }
        return nil
    }
    
    /**
     Removing all html, git, () tags. Also cleaning up multiple '\n\r' and whitespaces
    */
    static func cleanText(htmlPageUrl: String) -> String? {
        var content: String? = nil
        
        if let url = URL(string: htmlPageUrl) {
            content = try? String(contentsOf: url)
            // Stripping <> [] () tags
            content = content?.replacingOccurrences(of: "\\[[^>]*\\]|<[^>]*>|\\([^\\)]+\\)", with: "", options: .regularExpression, range: nil)
            // Stripping multiples \n\r
            content = content?.replacingOccurrences(of: "[\n\r]{3,}", with: " ", options: .regularExpression, range: nil)
            // Stripping multiples whitespaces
            content = content?.replacingOccurrences(of: "[\n][ ]+", with: "", options: .regularExpression, range: nil)
        }
        return content
    }
}

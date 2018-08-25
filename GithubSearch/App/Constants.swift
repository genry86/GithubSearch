//
//  Constants.swift
//  GithubSearch
//
//  Created by Genry on 8/24/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation
import UIColor_Hex_Swift

/**
  Struct with global constants
 */
struct Constants {
    
    /**
     Number of objects temporally storred in cache. When this limit is reaced, old object would be deleted.
     */
    static let cacheSize = 100
    
    /**
     Global Font constants
     */
    struct Font {
        static let Big: CGFloat = 18
        static let Middle: CGFloat = 14
        static let Small: CGFloat = 12
    }
    
    /**
     Global Color constants
     */
    struct Color {
        struct Text {
            static let Main = UIColor("#607d8b")
            static let Accessory = UIColor("#a5aeb3")
        }
    }
    
    /**
     Specific constants for Repos Table Screen
     */
    struct ReposList {
        
        static let countOfSymbolsToDoSearch = 3
        static let PageSize = 20
        static let CellHeight: CGFloat = 70.0
        
        /**
         Specific for Repos search bar constants
         */
        struct Search {
            static let RequestsInterval = 2.0
            static let BarHeight = 50
        }
    }
    
    /**
     Specific constants for any Cell in table
     */
    struct Cell {
        static let Margin = 5
        static let IconSize: CGFloat = 20
        static let DescriptionTopPadding = 15
        static let NameRightPadding = 40
    }
    
    /**
     Specific constants for Repo Details Screen
     */
    struct RepoDetails {
        static let IconSize: CGFloat = 32
        /**
         Standard margin between element and parent view
         */
        static let Margin = 20
        /**
         Vertical margin between elements
         */
        static let VPadding = 4
        
        /**
         Specific constants for Border in Repo Details Screen
         */
        struct Border {
            static let Radius: CGFloat = 8.0
            static let Width: CGFloat = 1
        }
        
        /**
         Specific constants for colors in Repo Details Screen
         */
        struct Color {
            struct Background {
                static let Top = UIColor("#ffffff")
                static let Bottom = UIColor("#f7f7f7")
                static let Segment = UIColor("#ffffff")
            }
            
            struct Text {
                static let UserName = UIColor("#ff5722")
            }
            
            static let SegmentBorder = UIColor("#bbbbbb")
        }
        
        /**
         Specific constants for Segment in Repo Details Screen
         */
        struct Segment {
            static let width = 300
            static let height = 45
        }
    }
    
    /**
     API URLs used to fetch data
     */
    struct Urls {
        /**
         URL for fetching specific number of repos, on specific page sorted by stars
         */
        static let Repos = "https://api.github.com/search/repositories?sort=stars&order=desc&repo=true&q=%@&page=%d&per_page=%d"
        /**
         URL for fetching readme file for specific owner and his repo
         */
        static let Readme = "https://raw.githubusercontent.com/%@/%@/master/README.md"
    }
}

//
//  BadgeSegmentControl+Extension.swift
//  GithubSearch
//
//  Created by Genry on 8/24/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import UIKit
import Foundation
import UIColor_Hex_Swift
import ionicons
import BadgeSegmentControl

extension BadgeSegmentControl {
    
    /**
     Initialize new BadgeSegmentControl object with parent view
     */
    convenience init(superView: UIView) {
        self.init()
        superView.addSubview(self)
    }
    
    
    private func segmentAppearence() -> BadgeSegmentControlAppearance {
        let appearance = BadgeSegmentControlAppearance()
        
        // Set background of all segments
        appearance.segmentOffSelectionColour = Constants.RepoDetails.Color.Background.Segment
        // Set Font weight and size of all segments
        appearance.titleOffSelectionFont = UIFont.boldSystemFont(ofSize: Constants.Font.Middle)
        
        // Set up border color/width/corner of all segments
        appearance.borderColor = Constants.RepoDetails.Color.SegmentBorder
        appearance.cornerRadius = Constants.RepoDetails.Border.Radius
        appearance.borderWidth = Constants.RepoDetails.Border.Width
        
        return appearance
    }
    
    /**
     Setting two elements of SegmentControl
     - parameters:
        - stars: count of stars on the left part of segment
        - forks: count of forks on the right part of segment
     */
    func setupSegmentItems(stars: Int, forks: Int) {
        // Getting Star icon
        let starIcon = IonIcons.image(withIcon: ion_star, size: Constants.RepoDetails.IconSize, color: Constants.Color.Text.Main)
        // Getting forks icon
        let forksIcon = IonIcons.image(withIcon: ion_network, size: Constants.RepoDetails.IconSize, color: Constants.Color.Text.Main)
        
        // Making it solid
        self.isOpaque = false
        // Prohibiting user's selection
        self.isUserInteractionEnabled = false
        // Setting up segment appearens (visual elements)
        self.segmentAppearance = segmentAppearence()
        // Setting big value of z-position to make it visible on top of other view
        self.layer.zPosition = 1
        
        // Creation of segments
        self.insertSegmentWithTitle(String(format: "%d Stars".localized(), stars), onSelectionImage: nil, offSelectionImage: starIcon, index: 0)
        self.insertSegmentWithTitle(String(format: "%d Forks".localized(), forks), onSelectionImage: nil, offSelectionImage: forksIcon, index: 1)
    }
}

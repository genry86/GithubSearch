//
//  DetailsView.swift
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

/**
  UI View with all elements For presenting Detailed info about selected Repo
 */
class DetailsView: UIView {
    
    // MARK: -
    // MARK: Properties
    // MARK: -
    
    /**
      Boolean flag to set elements constraints only once
     */
    private var shouldSetupConstraints = true
    
    /**
     Backgound on top half of screen (based on provided design)
     */
    var topBackgroundView: UIView!
    /**
     Backgound on bottom half of screen (based on provided design)
     */
    var bottomBackgroundView: UIView!
    
    /**
     Avatar Image of owner of repo
     */
    var avatarView: UIImageView!
    /**
     Username of owner
     */
    var userLoginLabel: UILabel!
    
    /**
     Description of repo
     */
    var descriptionTextView: UITextView!
    /**
     Readme.md scrolled string with stripped <> [] () tags
     */
    var readmeTextView: UITextView!

    /**
     Loading indicator animated unless avatar woudn't be downloaded
     */
    var avatarIndicator: UIActivityIndicatorView!
    /**
     Loading indicator animated unless readme woudn't be downloaded
     */
    var readmeIndicator: UIActivityIndicatorView!
    
    /**
     Custom SegmentConrol used to show stars and forsk counts
     */
    var gitSegmentControl: BadgeSegmentControl!
    
    // MARK: -
    // MARK: Lifecycle
    // MARK: -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Top and Boottom Background
        topBackgroundView = UIView(superView: self,
                                   backgroundColor: Constants.RepoDetails.Color.Background.Top)
        bottomBackgroundView = UIView(superView: self,
                                      backgroundColor: Constants.RepoDetails.Color.Background.Bottom)
        
        // Avatar
        avatarView = UIImageView(superView: topBackgroundView)
        // User Login
        userLoginLabel = UILabel(superView: topBackgroundView,
                                 font: UIFont.boldSystemFont(ofSize: Constants.Font.Big),
                                 textColor: Constants.RepoDetails.Color.Text.UserName)
       
        // Description
        descriptionTextView = UITextView(superView: topBackgroundView,
                                         textColor: Constants.Color.Text.Accessory,
                                         font: UIFont.systemFont(ofSize: Constants.Font.Small),
                                         alignment: .center)
        // Readme.md
        readmeTextView = UITextView(superView: bottomBackgroundView,
                                      textColor: Constants.Color.Text.Accessory,
                                      font: UIFont.systemFont(ofSize: Constants.Font.Small),
                                      backgroundColor: Constants.RepoDetails.Color.Background.Bottom)

        // Load Indicators
        avatarIndicator = UIActivityIndicatorView(superView: avatarView, style: .gray)
        readmeIndicator = UIActivityIndicatorView(superView: readmeTextView, style: .whiteLarge)

        // Git Segment
        gitSegmentControl = BadgeSegmentControl(superView: self)
    }
    
    override func updateConstraints() {
        // Setting up constraints
        if (shouldSetupConstraints) {
            
            // Top background
            topBackgroundView.snp.makeConstraints { make in
                make.top.equalTo(self.snp.top)
                make.left.equalTo(self.snp.left)
                make.right.equalTo(self.snp.right)
                make.bottom.equalTo(self.snp.centerY)
            }
            // Bottom background
            bottomBackgroundView.snp.makeConstraints { make in
                make.top.equalTo(self.topBackgroundView.snp.bottom)
                make.left.equalTo(self.snp.left)
                make.right.equalTo(self.snp.right)
                make.bottom.equalTo(self.snp.bottom)
            }
            
            // Avatar image
            avatarView.snp.makeConstraints { make in
                make.top.equalTo(self.topBackgroundView.snp.top).offset(Constants.RepoDetails.VPadding)
                make.bottom.equalTo(self.userLoginLabel.snp.top).offset(-Constants.RepoDetails.VPadding)
                make.width.equalTo(self.avatarView.snp.height)
                make.centerX.equalTo(self.topBackgroundView.snp.centerX)
            }
            // Avatar load indicator
            avatarIndicator.snp.makeConstraints { make in
                make.center.equalTo(avatarView.snp.center)
            }
            // Username of owner
            userLoginLabel.snp.makeConstraints { make in
                make.centerX.equalTo(self.topBackgroundView.snp.centerX)
                make.centerY.equalTo(self.topBackgroundView.snp.centerY).offset(Constants.RepoDetails.Margin)
            }
            
            // Description of Repo
            descriptionTextView.snp.makeConstraints { make in
                make.top.equalTo(self.userLoginLabel.snp.bottom).offset(Constants.RepoDetails.VPadding)
                make.bottom.equalTo(self.gitSegmentControl.snp.top).offset(-Constants.RepoDetails.VPadding)
                make.left.equalTo(self.topBackgroundView.snp.left).offset(Constants.RepoDetails.Margin)
                make.right.equalTo(self.topBackgroundView.snp.right).offset(-Constants.RepoDetails.Margin)
                make.centerX.equalTo(self.topBackgroundView.snp.centerX)
            }
            
            // Custom Segment control with stars/forks
            gitSegmentControl.snp.makeConstraints { make in
                make.center.equalTo(self.snp.center)
                make.width.equalTo(Constants.RepoDetails.Segment.width)
                make.height.equalTo(Constants.RepoDetails.Segment.height)
            }
            
            // Readme info
            readmeTextView.snp.makeConstraints { make in
                make.top.equalTo(self.gitSegmentControl.snp.bottom).offset(Constants.RepoDetails.Margin)
                make.left.equalTo(self.bottomBackgroundView.snp.left).offset(Constants.RepoDetails.Margin)
                make.right.equalTo(self.bottomBackgroundView.snp.right).offset(-Constants.RepoDetails.Margin)
                make.bottom.equalTo(self.bottomBackgroundView.snp.bottom).offset(-Constants.RepoDetails.Margin)
            }
            // Readme load indicator
            readmeIndicator.snp.makeConstraints { make in
                make.center.equalTo(readmeTextView.snp.center)
            }
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

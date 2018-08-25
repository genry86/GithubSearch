//
//  RepoTableViewCell.swift
//  GithubSearch
//
//  Created by Genry on 8/23/18.
//  Copyright © 2018 Genry. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa
import ReactiveSwift
import SnapKit
import Result
import UIColor_Hex_Swift
import ionicons

/**
 Repo cell for table list of repos
 */
class RepoTableViewCell: ReactiveTableViewCell<RepoCellViewModel> {
    
    // MARK: -
    // MARK: Properties
    // MARK: -
    
    /**
     Name of repo
     */
    private var nameLabel: UILabel!
    /**
     Description of repo
     */
    private var descriptionLabel: UILabel!
    
    /**
     Stars of repo
     */
    private var starsLabel: UILabel!
    /**
     Count of forks in repo
     */
    private var starsImage: UIImageView!
    
    /**
     Flag to setup constraints only once
     */
    private var didSetupConstraints = false
    
    // MARK: -
    // MARK: Lifecycle
    // MARK: -
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        // Main proj title and Description
        nameLabel = UILabel(superView: contentView)
        descriptionLabel = UILabel(superView: contentView, textColor: Constants.Color.Text.Accessory)
        
        // Star Icon and Text on the right side
        starsImage = UIImageView(superView: contentView, iconName: ion_star, size: Constants.Cell.IconSize)
        starsLabel = UILabel(superView: contentView)
        
        // Binding of view model properties to cell properties
        self.nameLabel.reactive.text <~ vm_signal.map { $0.name.value }.observe(on: UIScheduler())
        self.descriptionLabel.reactive.text <~ vm_signal.map { $0.desc.value }.observe(on: UIScheduler())
        self.starsLabel.reactive.text <~ vm_signal.map { "\($0.stars.value)" }.observe(on: UIScheduler())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        // Update constraints once
        if !didSetupConstraints {
            
            // Name of repo
            nameLabel.snp.makeConstraints { make in
                make.left.equalTo(contentView.snp.left).offset(Constants.Cell.Margin)
                make.top.equalTo(contentView.snp.top).offset(Constants.Cell.Margin)
                make.right.equalTo(contentView.snp.centerX).offset(Constants.Cell.NameRightPadding)
            }
            
            // Stars
            starsLabel.snp.makeConstraints { make in
                make.right.equalTo(contentView.snp.right).offset(-Constants.Cell.Margin)
                make.top.equalTo(nameLabel.snp.top)
            }
            
            // Star icon
            starsImage.snp.makeConstraints { make in
                make.width.equalTo(Constants.Cell.IconSize)
                make.height.equalTo(Constants.Cell.IconSize)
                make.right.equalTo(starsLabel.snp.left).offset(-Constants.Cell.Margin)
                make.top.equalTo(nameLabel.snp.top)
            }
            
            // Description
            descriptionLabel.snp.makeConstraints { make in
                make.left.equalTo(contentView.snp.left).offset(Constants.Cell.Margin)
                make.top.equalTo(nameLabel.snp.bottom).offset(Constants.Cell.DescriptionTopPadding)
                make.right.equalTo(contentView.snp.right).offset(-Constants.Cell.Margin)
            }

            didSetupConstraints = true
        }
    }
}

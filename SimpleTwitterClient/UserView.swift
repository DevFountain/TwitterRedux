//
//  UserView.swift
//  SimpleTwitterClient
//
//  Created by Curtis Wilcox on 4/21/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import AlamofireImage
import UIKit

class UserView: UIView {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!

    var user: User! {
        didSet {
            user = User.currentUser

            if let headerImageUrl = user.headerImageUrl {
                headerImageView.af_setImage(withURL: headerImageUrl, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true)
            }

            if let profileImageUrl = user.profileImageUrl {
                userProfileImageView.af_setImage(withURL: profileImageUrl, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true)
            }
            userProfileImageView.layer.cornerRadius = 5

            nameLabel.text = user.name

            screenNameLabel.text = user.screenName

            if let tweetCount = user.tweetCount {
                tweetsLabel.text = String(tweetCount)
            }

            if let followingCount = user.followingCount {
                followingLabel.text = String(followingCount)
            }

            if let followersCount = user.followersCount {
                followersLabel.text = String(followersCount)
            }
        }
    }

}


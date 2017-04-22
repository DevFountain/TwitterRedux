//
//  TweetCell.swift
//  SimpleTwitterClient
//
//  Created by Curtis Wilcox on 4/13/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import AlamofireImage
import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!

    var tweet: Tweet! {
        didSet {
            userProfileImageView.image = nil
            if let profileImageUrl = tweet.profileImageUrl {
                userProfileImageView.af_setImage(withURL: profileImageUrl, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: false)
            }
            userProfileImageView.layer.cornerRadius = 5

            screenNameLabel.text = "@\(tweet.screenName!)"

            if let date = tweet.createdAt {
                createdAtLabel.text = DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
            }

            tweetTextLabel.text = tweet.text
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        userProfileImageView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}


//
//  TweetCell.swift
//  SimpleTwitterClient
//
//  Created by Curtis Wilcox on 4/13/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!

    var tweet: Tweet! {
        didSet {
            if let profileImageURL = tweet.profileImageURL {
                userProfileImageView.af_setImage(withURL: profileImageURL, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true)
            }

            screenNameLabel.text = tweet.screenName

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


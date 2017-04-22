//
//  TweetViewController.swift
//  SimpleTwitterClient
//
//  Created by Curtis Wilcox on 4/15/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!

    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let tweet = self.tweet

        userProfileImageView.af_setImage(withURL: (tweet?.profileImageUrl)!, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: false)
        userProfileImageView.layer.cornerRadius = 5

        nameLabel.text = tweet?.name

        screenNameLabel.text = "@\((tweet?.screenName)!)"

        tweetTextLabel.text = tweet?.text

        if let date = tweet?.createdAt {
            createdAtLabel.text = DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .short)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func retweetButtonTap(_ sender: Any) {
        TwitterClient.sharedInstance.postRetweet(id: tweet.id!)
    }

    @IBAction func likeButtonTap(_ sender: Any) {
        TwitterClient.sharedInstance.postFavorite(parameters: ["id": "\(tweet.id!)"])
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Reply" {
            let composeViewController = segue.destination as! ComposeViewController
            composeViewController.replyToScreenName = tweet.screenName!
            composeViewController.parameters = ["in_reply_to_status_id": tweet.id_str!]
        }
    }

}


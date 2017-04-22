//
//  MentionsViewController.swift
//  SimpleTwitterClient
//
//  Created by Curtis Wilcox on 4/21/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import UIKit

class MentionsViewController: UITableViewController {

    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        getMentionsTimeline()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TweetCell

        cell.tweet = tweets[indexPath.row]

        // Configure the cell...

        return cell
    }

    func getMentionsTimeline() {
        Tweet.getMentionsTimeline { (tweets: [Tweet]?) in
            self.tweets = tweets
            self.tableView.reloadData()
        }
    }

    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        getMentionsTimeline()
        refreshControl.endRefreshing()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTweet" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)

            let tweetViewController = segue.destination as! TweetViewController
            tweetViewController.tweet = tweets[(indexPath?.row)!]
        }
    }

}


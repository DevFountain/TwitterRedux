//
//  ProfileViewController.swift
//  SimpleTwitterClient
//
//  Created by Curtis Wilcox on 4/21/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var userView: UserView!
    @IBOutlet weak var tableView: UITableView!

    var parameters: [String: String] = [:]

    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        if parameters["screen_name"] != nil {
            User.showUser(parameters: parameters, completion: { (user: User?) in
                self.userView.user = user
                self.navigationItem.title = self.userView.user.name
            })
        } else {
            userView.user = User.currentUser
            navigationItem.title = userView.user.name
            parameters["screen_name"] = userView.user.screenName
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUserTimeline()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TweetCell

        cell.tweet = tweets[indexPath.row]

        // Configure the cell...

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func getUserTimeline() {
        Tweet.getUserTimeline(parameters: parameters) { (tweets: [Tweet]?) in
            self.tweets = tweets
            self.tableView.reloadData()
        }
    }

    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        getUserTimeline()
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


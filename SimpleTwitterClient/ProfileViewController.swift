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

    var user: User!

    var parameters: [String: String] = [:]

    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        navigationItem.title = User.currentUser?.name

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        userView.user = user

        parameters["screen_name"] = User.currentUser?.screenName!

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


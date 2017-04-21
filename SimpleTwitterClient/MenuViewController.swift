//
//  MenuViewController.swift
//  SimpleTwitterClient
//
//  Created by Curtis Wilcox on 4/21/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    private var profileNavigationController: UIViewController!
    private var timelineNavigationController: UIViewController!
    private var mentionsNavigationController: UIViewController!

    var hamburgerViewController: HamburgerViewController!

    let titles = ["Profile", "Timeline", "Mentions", "Logout"]

    var viewControllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        profileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController")
        viewControllers.append(profileNavigationController)

        timelineNavigationController = storyboard.instantiateViewController(withIdentifier: "TimelineNavigationController")
        viewControllers.append(timelineNavigationController)

        mentionsNavigationController = storyboard.instantiateViewController(withIdentifier: "MentionsNavigationController")
        viewControllers.append(mentionsNavigationController)

        hamburgerViewController.contentViewController = timelineNavigationController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / CGFloat(titles.count)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...

        cell.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 255/255)

        cell.textLabel?.text = titles[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == titles.index(of: "Logout") {
            defaults.removeObject(forKey: "CurrentUserData")
            defaults.removeObject(forKey: "OAuthClient")
            hamburgerViewController.dismiss(animated: true)
        } else {
            hamburgerViewController.contentViewController = viewControllers[indexPath.row]
        }
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


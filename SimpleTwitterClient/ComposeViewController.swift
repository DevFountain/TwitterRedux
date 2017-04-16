//
//  ComposeViewController.swift
//  SimpleTwitterClient
//
//  Created by Curtis Wilcox on 4/15/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import UIKit
import AlamofireImage

class ComposeViewController: UIViewController {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var composeTextView: UITextView!

    var parameters: [String: String] = [:]

    var replyToScreenName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTap))

        let user = User.currentUser

        userProfileImageView.af_setImage(withURL: (user?.profileUrl)!, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: false)
        userProfileImageView.layer.cornerRadius = 5

        nameLabel.text = user?.name
        screenNameLabel.text = user?.screenName

        if !parameters.isEmpty {
            navigationItem.leftBarButtonItem = nil
            composeTextView.text = "\(replyToScreenName) "
        }

        composeTextView.layer.borderColor = UIColor.black.cgColor
        composeTextView.layer.cornerRadius = 5
        composeTextView.layer.borderWidth = 1/3
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        composeTextView.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        composeTextView.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cancelButtonTap() {
        dismiss(animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Tweet" {
            parameters["status"] = composeTextView.text
            TwitterClient.sharedInstance.postStatusUpdate(parameters: parameters)
        }
    }

}


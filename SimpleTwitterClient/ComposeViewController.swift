//
//  ComposeViewController.swift
//  SimpleTwitterClient
//
//  Created by Curtis Wilcox on 4/15/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import AlamofireImage
import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var composeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        userProfileImageView.af_setImage(withURL: (User.currentUser?.profileUrl)!, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: false)
        userProfileImageView.layer.cornerRadius = 5
        userProfileImageView.layer.masksToBounds = true

        nameLabel.text = User.currentUser?.name
        screenNameLabel.text = User.currentUser?.screenName

        composeTextView.layer.borderColor = UIColor.black.cgColor
        composeTextView.layer.cornerRadius = 5
        composeTextView.layer.borderWidth = 1/3
        composeTextView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTap(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func tweetButtonTap(_ sender: Any) {
        dismiss(animated: true) {
            let parameters = ["status": "\(self.composeTextView.text!)"]
            TwitterClient.sharedInstance.postStatusUpdate(parameters: parameters)
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

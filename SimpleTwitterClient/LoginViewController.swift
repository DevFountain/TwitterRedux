//
//  LoginViewController.swift
//  SimpleTwitterClient
//
//  Created by Curtis Wilcox on 4/12/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if defaults.object(forKey: "CurrentUserData") as? Data != nil {
            performSegue(withIdentifier: "PresentMenu", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTap(_ sender: Any) {
        TwitterClient.sharedInstance.getAuthorization(sender: self) {
            self.performSegue(withIdentifier: "PresentMenu", sender: self)
        }
    }

}


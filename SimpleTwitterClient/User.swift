//
//  User.swift
//  SimpleTwitterClient
//
//  Created by Curtis Wilcox on 4/12/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import UIKit

let defaults = UserDefaults.standard

class User: NSObject {

    var name: String?
    var screenName: String?
    var profileUrl: URL?
    var userDescription: String?

    var dictionary: NSDictionary?

    init(dictionary: NSDictionary) {
        self.dictionary = dictionary

        name = dictionary["name"] as? String

        screenName = "@\((dictionary["screen_name"] as? String)!)"

        if let profileUrlString = dictionary["profile_image_url_https"] as? String {
            profileUrl = URL(string: profileUrlString)
        }

        userDescription = dictionary["description"] as? String
    }

    class var currentUser: User? {
        get {
            var dictionary = NSDictionary()

            if let userData = defaults.object(forKey: "CurrentUserData") as? Data {
                dictionary = try! JSONSerialization.jsonObject(with: userData) as! NSDictionary
            }

            return User(dictionary: dictionary)
        }
        set(user) {
            if let user = user {
                let userData = try! JSONSerialization.data(withJSONObject: user.dictionary!)
                defaults.set(userData, forKey: "CurrentUserData")
            }
        }
    }

    static func verifyCredentials(completion: @escaping (User?) -> Void) {
        _ = TwitterClient.sharedInstance.verifyCredentials(completion: completion)
    }

}


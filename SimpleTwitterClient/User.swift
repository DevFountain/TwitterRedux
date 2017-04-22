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
    var headerImageUrl: URL?
    var profileImageUrl: URL?
    var userDescription: String?
    var tweetCount: Int?
    var followingCount: Int?
    var followersCount: Int?

    var dictionary: NSDictionary?

    init(dictionary: NSDictionary) {
        self.dictionary = dictionary

        name = dictionary["name"] as? String

        screenName = "@\((dictionary["screen_name"] as? String)!)"

        if let headerImageUrlString = dictionary["profile_background_image_url_https"] as? String {
            headerImageUrl = URL(string: headerImageUrlString)
        }

        if let profileImageUrlString = dictionary["profile_image_url_https"] as? String {
            profileImageUrl = URL(string: profileImageUrlString)
        }

        userDescription = dictionary["description"] as? String

        tweetCount = dictionary["statuses_count"] as? Int

        followingCount = dictionary["friends_count"] as? Int

        followersCount = dictionary["followers_count"] as? Int
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


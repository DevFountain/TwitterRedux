//
//  User.swift
//  SimpleTwitterClient
//
//  Created by Curtis Wilcox on 4/12/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: String?
    var screenName: String?
    var profileUrl: URL?
    var userDescription: String?

    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String

        screenName = dictionary["screen_name"] as? String

        if let profileUrlString = dictionary["profile_image_url_https"] as? String {
            profileUrl = URL(string: profileUrlString)
        }

        userDescription = dictionary["description"] as? String
    }

    static func getCurrentAccount(completion: @escaping (User?) -> Void) {
        _ = TwitterClient.sharedInstance.getCurrentAccount(completion: completion)
    }

}


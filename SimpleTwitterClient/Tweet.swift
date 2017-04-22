//
//  Tweet.swift
//  SimpleTwitterClient
//
//  Created by Curtis Wilcox on 4/12/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var profileImageUrl: URL?
    var screenName: String?
    var name: String?
    var createdAt: Date?
    var text: String?
    var id: Int?
    var id_str: String?

    init(dictionary: NSDictionary) {
        let user = dictionary["user"] as? NSDictionary

        if let profileImageUrlString = user?["profile_image_url_https"] as? String {
            profileImageUrl = URL(string: profileImageUrlString)
        }

        name = user?["name"] as? String

        screenName = (user?["screen_name"] as? String)!

        if let createdAtString = dictionary["created_at"] as? String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            createdAt = formatter.date(from: createdAtString)
        }

        text = dictionary["text"] as? String

        id = dictionary["id"] as? Int

        id_str = dictionary["id_str"] as? String
    }

    class func getTweets(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()

        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }

        return tweets
    }

    static func getHomeTimeline(completion: @escaping ([Tweet]?) -> Void) {
        _ = TwitterClient.sharedInstance.getHomeTimeline(completion: completion)
    }

    static func getUserTimeline(parameters: Dictionary<String, String>, completion: @escaping ([Tweet]?) -> Void) {
        _ = TwitterClient.sharedInstance.getUserTimeline(parameters: parameters, completion: completion)
    }

    static func getMentionsTimeline(completion: @escaping ([Tweet]?) -> Void) {
        _ = TwitterClient.sharedInstance.getMentionsTimeline(completion: completion)
    }

}


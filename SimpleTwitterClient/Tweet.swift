//
//  Tweet.swift
//  SimpleTwitterClient
//
//  Created by Curtis Wilcox on 4/12/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var profileImageURL: URL?



    var text: String?
    var timestamp: Date?
    var retweetCount: Int?
    var favoritesCount: Int?

    init(dictionary: NSDictionary) {
        let profileImageURLString = dictionary["profile_image_url_https"] as? String
        if profileImageURLString != nil {
            profileImageURL = URL(string: profileImageURLString!)
        } else {
            profileImageURL = nil
        }





        text = dictionary["text"] as? String

        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"

            timestamp = formatter.date(from: timestampString)
        }

        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0

        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
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

}


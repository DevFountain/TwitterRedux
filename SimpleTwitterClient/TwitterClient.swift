//
//  TwitterClient.swift
//  SimpleTwitterClient
//
//  Created by Curtis Wilcox on 4/12/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import Alamofire
import OAuthSwift
import TwitterAPI

class TwitterClient {

    static let sharedInstance = TwitterClient()

    private let oauthSwift = OAuth1Swift(consumerKey: consumerKey, consumerSecret: consumerSecret, requestTokenUrl: "https://api.twitter.com/oauth/request_token", authorizeUrl: "https://api.twitter.com/oauth/authorize", accessTokenUrl: "https://api.twitter.com/oauth/access_token")

    func authTwitterClient(sender: UIViewController, completion: @escaping () -> Void) {
        oauthSwift.authorizeURLHandler = SafariURLHandler(viewController: sender, oauthSwift: oauthSwift)
        oauthSwift.authorize(withCallbackURL: URL(string: "simple-twitter-client://oauth-callback/twitter")!, success: { (credential, response, parameters) in

            let client = OAuthClient(consumerKey: consumerKey, consumerSecret: consumerSecret, accessToken: credential.oauthToken, accessTokenSecret: credential.oauthTokenSecret)
            let string = client.serialize
            defaults.set(string, forKey: "OAuthClient")

            self.getCurrentUser(completion: { (user: User?) in
                User.currentUser = user
            })

            completion()

        }) { (error) in
            print(error.localizedDescription)
        }
    }

    func getCurrentUser(completion: @escaping (User?) -> Void) {
        let string = defaults.object(forKey: "OAuthClient") as! String
        let client = ClientDeserializer.deserialize(string)

        Alamofire.request(client.makeRequest(.GET, url: "https://api.twitter.com/1.1/account/verify_credentials.json", parameters: [:])).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                if let response = response.result.value as? NSDictionary {
                    completion(User(dictionary: response))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getHomeTimeline(completion: @escaping ([Tweet]?) -> Void) {
        let string = defaults.object(forKey: "OAuthClient") as! String
        let client = ClientDeserializer.deserialize(string)

        Alamofire.request(client.makeRequest(.GET, url: "https://api.twitter.com/1.1/statuses/home_timeline.json", parameters: [:])).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                if let response = response.result.value as? [NSDictionary] {
                    completion(Tweet.getTweets(dictionaries: response))
                }
            case .failure (let error):
                print(error.localizedDescription)
            }
        }
    }

}


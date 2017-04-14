//
//  TwitterClient.swift
//  SimpleTwitterClient
//
//  Created by Curtis Wilcox on 4/12/17.
//  Copyright © 2017 DevFountain LLC. All rights reserved.
//

import Alamofire
import OAuthSwift
import OAuthSwiftAlamofire

class TwitterClient: SessionManager {

    static let sharedInstance = TwitterClient()

    private let oauthSwift = OAuth1Swift(consumerKey: consumerKey, consumerSecret: consumerSecret, requestTokenUrl: "https://api.twitter.com/oauth/request_token", authorizeUrl: "https://api.twitter.com/oauth/authorize", accessTokenUrl: "https://api.twitter.com/oauth/access_token")

    func authTwitterClient(sender: UIViewController, completion: @escaping () -> Void) {
        oauthSwift.authorizeURLHandler = SafariURLHandler(viewController: sender, oauthSwift: oauthSwift)

        self.adapter = oauthSwift.requestAdapter

        oauthSwift.authorize(withCallbackURL: URL(string: "simple-twitter-client://oauth-callback/twitter")!, success: { (credential, response, parameters) in
            print("authorized")
            completion()
        }) { (error) in
            print("not authorized - \(error.localizedDescription)")
        }
    }

    func getCurrentAccount(completion: @escaping (User?) -> Void) {
        self.request("https://api.twitter.com/1.1/account/verify_credentials.json").validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success:
                if let response = response.result.value as? NSDictionary {
                    completion(User(dictionary: response))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

    func getHomeTimeline(completion: @escaping ([Tweet]?) -> Void) {
        self.request("https://api.twitter.com/1.1/statuses/home_timeline.json").validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success:
                if let response = response.result.value as? [NSDictionary] {
                    completion(Tweet.getTweets(dictionaries: response))
                }
            case .failure (let error):
                print(error.localizedDescription)
            }
        })
    }

}


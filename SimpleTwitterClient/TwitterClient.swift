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

    func getAuthorization(sender: UIViewController, completion: @escaping () -> Void) {
        oauthSwift.authorizeURLHandler = SafariURLHandler(viewController: sender, oauthSwift: oauthSwift)
        oauthSwift.authorize(withCallbackURL: URL(string: "simple-twitter-client://oauth-callback/twitter")!, success: { (credential, response, parameters) in

            let client = OAuthClient(consumerKey: consumerKey, consumerSecret: consumerSecret, accessToken: credential.oauthToken, accessTokenSecret: credential.oauthTokenSecret)
            let string = client.serialize
            defaults.set(string, forKey: "OAuthClient")

            self.verifyCredentials(completion: { (user: User?) in
                User.currentUser = user
            })

            completion()

        }) { (error) in
            print(error.localizedDescription)
        }
    }

    func verifyCredentials(completion: @escaping (User?) -> Void) {
        let string = defaults.object(forKey: "OAuthClient") as! String
        let client = ClientDeserializer.deserialize(string)

        Alamofire.request(client.makeRequest(.GET, url: "https://api.twitter.com/1.1/account/verify_credentials.json", parameters: [:])).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                if let response = response.result.value as? NSDictionary {
                    completion(User(dictionary: response))
                }
            case .failure (let error):
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

    func postStatusUpdate(parameters: Dictionary<String, String>) {
        let string = defaults.object(forKey: "OAuthClient") as! String
        let client = ClientDeserializer.deserialize(string)

        Alamofire.request(client.makeRequest(.POST, url: "https://api.twitter.com/1.1/statuses/update.json", parameters: parameters)).validate().responseData { (response) in
            switch response.result {
            case .success:
                print("success")
            case .failure (let error):
                print(error.localizedDescription)
            }
        }
    }

    func postRetweet(id: Int) {
        let string = defaults.object(forKey: "OAuthClient") as! String
        let client = ClientDeserializer.deserialize(string)

        Alamofire.request(client.makeRequest(.POST, url: "https://api.twitter.com/1.1/statuses/retweet/\(id).json", parameters: [:])).validate().responseData { (response) in
            switch response.result {
            case .success:
                print("success")
            case .failure (let error):
                print(error.localizedDescription)
            }
        }
    }

    func postFavorite(parameters: Dictionary<String, String>) {
        let string = defaults.object(forKey: "OAuthClient") as! String
        let client = ClientDeserializer.deserialize(string)

        Alamofire.request(client.makeRequest(.POST, url: "https://api.twitter.com/1.1/favorites/create.json", parameters: parameters)).validate().responseData { (response) in
            switch response.result {
            case .success:
                print("success")
            case .failure (let error):
                print(error.localizedDescription)
            }
        }
    }

    func getUserTimeline(parameters: Dictionary<String, String>, completion: @escaping ([Tweet]?) -> Void) {
        let string = defaults.object(forKey: "OAuthClient") as! String
        let client = ClientDeserializer.deserialize(string)

        Alamofire.request(client.makeRequest(.GET, url: "https://api.twitter.com/1.1/statuses/user_timeline.json", parameters: parameters)).validate().responseJSON { (response) in
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

    func getMentionsTimeline(completion: @escaping ([Tweet]?) -> Void) {
        let string = defaults.object(forKey: "OAuthClient") as! String
        let client = ClientDeserializer.deserialize(string)

        Alamofire.request(client.makeRequest(.GET, url: "https://api.twitter.com/1.1/statuses/mentions_timeline.json", parameters: [:])).validate().responseJSON { (response) in
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

    func showUser(parameters: Dictionary<String, String>, completion: @escaping (User?) -> Void) {
        let string = defaults.object(forKey: "OAuthClient") as! String
        let client = ClientDeserializer.deserialize(string)

        Alamofire.request(client.makeRequest(.GET, url: "https://api.twitter.com/1.1/users/show.json", parameters: parameters)).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                if let response = response.result.value as? NSDictionary {
                    completion(User(dictionary: response))
                }
            case .failure (let error):
                print(error.localizedDescription)
            }
        }
    }

}


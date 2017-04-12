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

class TwitterClient {

    static let sharedInstance = TwitterClient()

    func doTwitterOAuth() {
        let oauthSwift = OAuth1Swift(
            consumerKey: consumerKey,
            consumerSecret: consumerSecret,
            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
            authorizeUrl: "https://api.twitter.com/oauth/authorize",
            accessTokenUrl: "https://api.twitter.com/oauth/access_token"
        )

        oauthSwift.authorize(
            withCallbackURL: URL(string: "simple-twitter-client://oauth-callback/twitter")!,
            success: { (credential, response, parameters) in
                print(credential.oauthToken)
                print(credential.oauthTokenSecret)
                print(parameters["user_id"]!)
        }) { (error) in
            print(error.localizedDescription)
        }

        let sessionManager = SessionManager.default
        sessionManager.adapter = oauthSwift.requestAdapter

        sessionManager.request("https://api.twitter.com/oauth2/token")
    }

}


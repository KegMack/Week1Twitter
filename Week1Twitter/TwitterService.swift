//
//  TwitterService.swift
//  Week1Twitter
//
//  Created by User on 3/31/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import Foundation
import Accounts
import Social

class TwitterService {
  
  var account: ACAccount?
  let homeTimelineURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
  
  init(){}
  
  func fetchHomeTimeline(completionHandler:([Tweet]?, String?) -> Void) {
    let requestURL = NSURL(string: homeTimelineURL)
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    request.account = account
    
    request.performRequestWithHandler { (data, response, error) -> Void in
      var errorDescription: String? = nil
      var tweets: [Tweet]? = nil
      if error != nil {
        errorDescription = "Unable to log in to Twitter, check your settings."
      } else {
        switch response.statusCode {
        case 200...299:
          tweets = TweetJSONParser.tweetsFromJSONData(data)
        case 400...499:
          errorDescription = "URL Not found."
        case 500...599:
          errorDescription = "Server busy, Try again later."
        default:
          errorDescription = "Unknown network error.  Try again"
        }
      }
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        completionHandler(tweets, errorDescription)
      })
    }
  }
  
  func fetchFullTweetWithID(id: Int, completionHandler:(Tweet?, String?) -> Void) {
    let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/show.json?id=\(id)")
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    request.account = account
    
    request.performRequestWithHandler { (data, response, error) -> Void in
      var tweet: Tweet? = nil
      var errorDescription: String? = nil
      if error != nil {
        errorDescription = "Unable to log in to Twitter, check your settings."
      } else {
        switch response.statusCode {
        case 200...299:
          tweet = TweetJSONParser.tweetFromJSONData(data)
        case 400...499:
          errorDescription = "URL Not found."
        case 500...599:
          errorDescription = "Server busy, Try again later."
        default:
          errorDescription = "Unknown network error.  Try again"
        }
      }
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        completionHandler(tweet, errorDescription)
      })
    }
  }
}
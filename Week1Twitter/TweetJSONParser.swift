//
//  TweetJSONParser.swift
//  Week1Twitter
//
//  Created by User on 3/31/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import Foundation

class TweetJSONParser {
  
  class func tweetsFromJSONData(data: NSData) -> [Tweet] {

    var tweets = [Tweet]()
    var error: NSError?
    if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:&error) as? [[String: AnyObject]] {
      for object in jsonObject {
        if let text = object["text"] as? String {
          if let id = object["id"] as? Int {
            if let retweets = object["retweet_count"] as? Int {
              if let favorited = object["favorite_count"] as? Int {
                if let user = object["user"] as? [String: AnyObject] {
                  if let userName = user["name"] as? String {
                    if let screenName = user["screen_name"] as? String {
                      if let imageUrl = user["profile_image_url"] as? String {
                        if let bgImageUrl = user["profile_background_image_url"] as? String {
                          tweets.append(Tweet(userName: userName, screenName: screenName, text: text, id: id, retweets: retweets, favorited: favorited, imageUrl: imageUrl, bgImageUrl: bgImageUrl) )
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    return tweets
  }
  
  class func fullTweetFromJSONData(data: NSData) -> Tweet? {
    var error: NSError?
    if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:&error) as? [String: AnyObject] {
      if let id = jsonObject["id"] as? Int {
        if let user = jsonObject["user"] as? [String: AnyObject] {
          if let userName = user["name"] as? String {
            if let screenName = user["screen_name"] as? String {
              if let imageUrl = user["profile_image_url"] as? String {
                if let bgImageUrl = user["profile_background_image_url"] as? String {
                  if let retweets = jsonObject["retweet_count"] as? Int {
                    if let favorited = jsonObject["favorite_count"] as? Int {
                      if let retweetedStatus = jsonObject["retweeted_status"] as? [String: AnyObject]{
                        if let text = retweetedStatus["text"] as? String {
                          return Tweet(userName: userName, screenName: screenName, text: text, id: id, retweets: retweets, favorited: favorited, imageUrl: imageUrl, bgImageUrl: bgImageUrl)
                        }
                      }
                      else if let text = jsonObject["text"] as? String {
                        return Tweet(userName: userName, screenName: screenName, text: text, id: id, retweets: retweets, favorited: favorited, imageUrl: imageUrl, bgImageUrl: bgImageUrl)
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    return nil
  }
  
//  private func parseTweet(data: [String:AnyObject]) -> Tweet? {
//    var tweet: Tweet? = nil
//    if let text = data["text"] as? String {
//      if let id = data["id"] as? Int {
//        if let user = data["user"] as? [String: AnyObject] {
//          if let userName = user["name"] as? String {
//            tweet = Tweet(userName: userName, text: text, id: id)
//          }
//        }
//      }
//    }
//    return tweet
//  }
  
}

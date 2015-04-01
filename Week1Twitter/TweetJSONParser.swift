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
          if let user = object["user"] as? [String: AnyObject] {
            if let userName = user["name"] as? String {
              tweets.append(Tweet(userName: userName, text: text))
            }
          }
        }
      }
    }
    return tweets
  }
  
  
}

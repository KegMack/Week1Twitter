//
//  Tweet.swift
//  Week1Twitter
//
//  Created by User on 3/31/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class Tweet {
  
  var text: String
  var userName: String
  var screenName: String
  var id: Int
  var retweets: Int
  var favorited: Int
  var imageUrl: String
  var backgroundImageURL: String
  var image: UIImage?
  var backgroundImage: UIImage?
  
  init(userName: String, screenName: String, text: String, id: Int, retweets: Int, favorited: Int, imageUrl: String, bgImageUrl: String) {
    self.text = text
    self.userName = userName
    self.screenName = screenName
    self.id = id
    self.retweets = retweets
    self.favorited = favorited
    self.imageUrl = imageUrl
    self.backgroundImageURL = bgImageUrl
  }
}

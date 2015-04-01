//
//  Tweet.swift
//  Week1Twitter
//
//  Created by User on 3/31/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import Foundation

class Tweet {
  
  var text: String?
  var userName: String?
  
  init(userName: String, text: String) {
    self.text = text
    self.userName = userName
  }
}

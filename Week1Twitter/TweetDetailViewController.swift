//
//  TweetDetailViewController.swift
//  Week1Twitter
//
//  Created by User on 4/1/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
  
  var tweet: Tweet?
  let twitterService = TwitterService()

  @IBOutlet weak var tweetLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.activityIndicator.startAnimating()
    if let id = self.tweet?.id? {
      TwitterLogin.requestAccount { (account, errorDescription) -> Void in
        if account != nil {
          self.twitterService.account = account
          self.twitterService.fetchFullTweetWithID(id, completionHandler: { (tweet, errorDescription) -> Void in
            self.activityIndicator.stopAnimating()
            if errorDescription != nil {
              self.tweetLabel.text = "Error: \(errorDescription)"
            }
            else if tweet != nil {
              self.tweetLabel.text = tweet!.text
            }
          })
        }
      }
    }
  }

  
  
}

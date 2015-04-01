//
//  TimelineViewController.swift
//  Week1Twitter
//
//  Created by User on 3/31/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class TimelineViewController: UITableViewController {
  
  struct Constants {
    static let tweetCellIdentifier = "tweetCell"
  }
  
  var tweets: [Tweet]?
  let twitterService = TwitterService()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    TwitterLogin.requestAccount { (account, errorDescription) -> Void in
      if account != nil {
        self.twitterService.account = account
        self.twitterService.fetchHomeTimeline({ (tweets, errorDescription) -> Void in
          if errorDescription != nil {
            println(errorDescription)
          }
          if tweets != nil {
            self.tweets = tweets
            self.tableView.reloadData()
          }
        })
      }
    }
//    if let filePath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") {
//      if let data = NSData(contentsOfFile: filePath) {
//        self.tweets = TweetJSONParser.tweetsFromJSONData(data)
//      }
//    }
  }

    // MARK: - Table view data source

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let tweets = self.tweets {
      return tweets.count
    }
    return 0
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(Constants.tweetCellIdentifier, forIndexPath: indexPath) as UITableViewCell
    cell.textLabel?.text = nil
    cell.detailTextLabel?.text = nil
    if let tweet = self.tweets?[indexPath.row] {
      cell.textLabel?.text = tweet.text
      cell.detailTextLabel?.text = tweet.userName
    }
    return cell
  }
}

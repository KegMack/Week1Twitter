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
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "Home Timeline"
    self.activityIndicator.center = self.tableView.center
    self.activityIndicator.startAnimating()
    self.tableView.rowHeight = UITableViewAutomaticDimension
    
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
            self.activityIndicator.stopAnimating()
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
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.tableView.reloadData()
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
    let cell = tableView.dequeueReusableCellWithIdentifier(Constants.tweetCellIdentifier, forIndexPath: indexPath) as TweetTableViewCell
    cell.userNameLabel.text = nil
    cell.tweetLabel.text = nil
    if let tweet = self.tweets?[indexPath.row] {
      cell.userNameLabel.text = tweet.userName
      cell.tweetLabel.text = tweet.text
    }
    return cell
  }
  
    // MARK: - Table view delegate
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("detailSegue", sender: indexPath.row)
  }
  
    // MARK: - Segue
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "detailSegue" {
      if let index = sender as? Int {
        if let destinationVC = segue.destinationViewController as? TweetDetailViewController {
          destinationVC.tweet = self.tweets![index]
        }
      }
    }
  }
  
  
  
  
}


//
//  TimelineViewController.swift
//  Week1Twitter
//
//  Created by User on 3/31/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  struct Constants {
    static let tweetCellIdentifier = "tweetCell"
  }
  
  var screenName: String?
  var tweets: [Tweet]?
  let imageService = ProfileImageService()
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  
  // MARK: - Initialization
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.activityIndicator.startAnimating()
    let nib = UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle())
    self.tableView.registerNib(nib, forCellReuseIdentifier: Constants.tweetCellIdentifier)
    self.tableView.estimatedRowHeight = 5
    self.tableView.rowHeight = UITableViewAutomaticDimension
    initializeTweetData()
  //  initializeTitle()
  }
  
  func initializeTweetData() {
    TwitterLogin.requestAccount { (account, errorDescription) -> Void in
      if account != nil {
        TwitterService.sharedService.account = account
        TwitterService.sharedService.fetchTimeline(self.screenName, { (tweets, errorDescription) -> Void in
          if errorDescription != nil {
            println(errorDescription)
          }
          if tweets != nil {
            self.tweets = tweets
            self.tableView.reloadData()
            self.initializeHeader()
            self.activityIndicator.stopAnimating()
          }
        })
      }
    }
  }
  
  func initializeTitle() {
    if self.screenName != nil {
      self.navigationItem.title = self.screenName
    } else {
      self.navigationItem.title = "Home"
    }
  }
  
  func initializeHeader() {
    if self.screenName != nil {
      if let tweets = self.tweets {
        let tweet = tweets.first
        let headerView = NSBundle.mainBundle().loadNibNamed("TwitterUserHeaderView", owner: self, options: nil)[0] as? TweetTableHeaderView
        headerView?.locationLabel.text = tweet!.userLocation
        headerView?.locationLabel.sizeToFit() 
        headerView?.retweetsLabel.text = "\(tweet!.userTweets)"
        headerView?.favoritedLabel.text = "\(tweet!.userFavorites)"
        if let profileImage = tweet?.image {
          headerView?.profileImageView.image = profileImage
        } else {
          self.imageService.fetchProfileImage(tweet!.imageUrl, completionHandler: { [weak self] (image) -> () in
            if self != nil {
              headerView?.profileImageView.image = image
            }
          })
        }
        if let bgImage = tweet!.backgroundImage {
            headerView?.backgroundImageView.image = bgImage
        } else {
          self.imageService.fetchProfileImage(tweet!.backgroundImageURL, completionHandler: { [weak self] (image) -> () in
            if self != nil {
              headerView?.backgroundImageView.image = image
            }
          })
        }
        self.tableView.tableHeaderView = headerView
        self.navigationItem.title = tweet?.userName
      }
    } else {
      self.navigationItem.title = "Home"
    }
  }
  
    // MARK: - Table view data source

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let tweets = self.tweets {
      return tweets.count
    }
    return 0
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier(Constants.tweetCellIdentifier, forIndexPath: indexPath) as TweetTableViewCell
    cell.tag++
    let tag = cell.tag
    cell.userNameLabel.text = nil
    cell.tweetLabel.text = nil
    cell.retweetedLabel.text = "0"
    cell.favoritedLabel.text = "0"
    
    if let tweet = self.tweets?[indexPath.row] {
      cell.userNameLabel.text = tweet.userName
      cell.tweetLabel.text = tweet.text
      cell.retweetedLabel.text = "\(tweet.retweets)"
      cell.favoritedLabel.text = "\(tweet.favorited)"
      if let image = tweet.image {
        cell.profileImageButton.setBackgroundImage(image, forState: UIControlState.Normal)
      } else {
        self.imageService.fetchProfileImage(tweet.imageUrl, completionHandler: { [weak self] (image) -> () in
          if self != nil {
            tweet.image = image
          }
          if tag == cell.tag {
            cell.profileImageButton.setBackgroundImage(image, forState: UIControlState.Normal)
          }
        })
      }
    }
    cell.layoutIfNeeded()
    return cell
  }
  
  
    // MARK: - Table view delegate
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let detailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TweetDetailViewController") as TweetDetailViewController
    let tweet = self.tweets![indexPath.row]
    detailViewController.tweet = tweet
    self.navigationController?.pushViewController(detailViewController, animated: true)
  }
  

  
}


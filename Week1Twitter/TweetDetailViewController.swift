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
  var imageService = ProfileImageService()
  
  @IBOutlet weak var tweetLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var backgroundImage: UIImageView!
  @IBOutlet weak var profileImageButton: UIButton!
  @IBOutlet weak var favoritesLabel: UILabel!
  @IBOutlet weak var retweetLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.activityIndicator.startAnimating()
    if self.tweet != nil {
      self.navigationItem.title = self.tweet!.userName
      displayTweet()
      displayImages()
    }
  }
  
  func displayTweet() {
    if let id = self.tweet?.id {
      TwitterLogin.requestAccount { (account, errorDescription) -> Void in
        if account != nil {
          TwitterService.sharedService.fetchFullTweetWithID(id, completionHandler: { (tweet, errorDescription) -> Void in
            self.activityIndicator.stopAnimating()
            if errorDescription != nil {
              self.tweetLabel.text = "Error: \(errorDescription)"
            }
            else if tweet != nil {
              self.tweetLabel.text = tweet!.text
              self.retweetLabel.text = "\(tweet!.retweets)"
              self.favoritesLabel.text = "\(tweet!.favorited)"
            }
          })
        }
      }
    }
  }
  
  func displayImages() {
    if let profileImage = self.tweet?.image {
      self.profileImageButton.setBackgroundImage(profileImage, forState: UIControlState.Normal)
    } else {
      self.imageService.fetchProfileImage(self.tweet!.imageUrl, completionHandler: { [weak self] (image) -> () in
        if self != nil {
          self?.profileImageButton.setBackgroundImage(image, forState: UIControlState.Normal)        }
      })
    }
    if let bgImage = self.tweet?.backgroundImage {
      self.backgroundImage.image = bgImage
    } else {
      self.imageService.fetchProfileImage(self.tweet!.backgroundImageURL, completionHandler: { [weak self] (image) -> () in
        if self != nil {
          self?.backgroundImage.image = image
        }
      })
    }
  }
  
  @IBAction func profileImagePressed(sender: UIButton) {
    if self.tweet != nil {
      let timelineViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TimelineViewController") as TimelineViewController
      timelineViewController.screenName = self.tweet!.screenName
      self.navigationController?.pushViewController(timelineViewController, animated: true)
    }
  }
  
}

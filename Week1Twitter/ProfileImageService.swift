//
//  ProfileImageService.swift
//  Week1Twitter
//
//  Created by User on 4/2/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class ProfileImageService {
  
  let imageQueue = NSOperationQueue()
  
  func fetchProfileImage(url: String, completionHandler: (UIImage) -> () ) {
    self.imageQueue.addOperationWithBlock { () -> Void in
      if let imageUrl = NSURL(string: url) {
        if let imageData = NSData(contentsOfURL: imageUrl) {
          if let image = UIImage(data: imageData) {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              completionHandler(image)
            })
          }
        }
      }
    }
  }
  
}

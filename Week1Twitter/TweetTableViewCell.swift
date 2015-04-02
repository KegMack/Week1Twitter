//
//  TweetTableViewCell.swift
//  Week1Twitter
//
//  Created by User on 4/1/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

  @IBOutlet weak var tweetLabel: UILabel!
  @IBOutlet weak var userNameLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

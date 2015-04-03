//
//  TwitterLogin.swift
//  Week1Twitter
//
//  Created by User on 3/31/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import Accounts

class TwitterLogin {
  
  class func requestAccount(completionHandler: (ACAccount?, String?) -> Void) {
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (accessGranted, error) -> Void in
      if accessGranted && error == nil {
        if let accounts = accountStore.accountsWithAccountType(accountType) as? [ACAccount] {
          if !accounts.isEmpty {
            let twitterAccount = accounts[0]
            completionHandler(twitterAccount, nil)
          }
        }
      } else {
        completionHandler(nil, "Unable to access Twitter Account")
      }
    }
  }
}
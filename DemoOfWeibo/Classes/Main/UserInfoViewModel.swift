//
//  UserInfoViewModel.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/24.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class UserInfoViewModel {
    
    static let shareInstace: UserInfoViewModel = UserInfoViewModel()
    
    var account: UserInfo?
    
    var accountPath: String {
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (accountPath as NSString).appendingPathComponent("accountInfo.plist")
    }
    
    var isLogin: Bool {
        
        if account == nil {
            return false
        }
        
        guard let expireseDate = account?.expires_date else {
            return false
        }
        
        return expireseDate.compare(Date()) == ComparisonResult.orderedDescending
        
    }
    
    
    init() {
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserInfo
    }
}

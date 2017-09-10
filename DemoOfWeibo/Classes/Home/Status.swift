//
//  Status.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/26.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class Status: NSObject {
    
    var created_at: String?
    var source: String?
    var text: String?
    var mid: Int = 0
    var user: User?
    var pic_urls: [[String: String]]?
    
    var retweeted_status: Status?

    
    
    init(dict: [String: AnyObject]){
        super.init()
        
        setValuesForKeys(dict)
        
        if let userDict = dict["user"] as? [String: AnyObject] {
            user = User(dict: userDict)
        }
    
        if let retweetedStatusDict = dict["retweeted_status"] as? [String: AnyObject] {
            retweeted_status = Status(dict: retweetedStatusDict)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

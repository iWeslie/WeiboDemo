//
//  UserInfo.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/21.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class UserInfo: NSObject, NSCoding {

    var access_token: String?
    
    var expires_in: TimeInterval = 0.0 {
        didSet {
            expires_date = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    var uid: String?
    
    var expires_date: Date?
    
    var screen_name: String?
    
    var avatar_hd: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String {
        return dictionaryWithValues(forKeys: ["access_token", "expires_date", "uid", "screen_name", "avatar_hd"]).description
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? Date
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        avatar_hd = aDecoder.decodeObject(forKey: "avatar_hd") as? String
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(avatar_hd, forKey: "avatar_hd")
    }
    
    
    
    
}

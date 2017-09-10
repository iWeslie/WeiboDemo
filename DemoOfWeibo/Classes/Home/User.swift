//
//  User.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/28.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class User: NSObject {
    var profile_image_url : String?
    var screen_name: String?
    var verified_type: Int = -1
    var mbrank: Int = 0
    
    init(dict : [String: AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

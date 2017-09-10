//
//  UIBarButtonItem-Extension.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/14.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(imageName: String) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        
        self.init(customView: btn)                                                                                              //init with customView
    }
    
}

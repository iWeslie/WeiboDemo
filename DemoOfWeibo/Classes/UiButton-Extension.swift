//
//  UiButton-Extension.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/10.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

extension UIButton {
     convenience init(normalImg: String, bgImg: String) {
        self.init()
        setImage(UIImage(named: normalImg), for: .normal)
        setImage(UIImage(named: normalImg + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named: bgImg), for: .normal)
        setBackgroundImage(UIImage(named: bgImg + "_highlighted"), for: .highlighted)
        sizeToFit()
        
    }
}

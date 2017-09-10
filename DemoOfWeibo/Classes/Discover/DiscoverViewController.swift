//
//  DiscoverViewController.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/10.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class DiscoverViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitor.setpresentView(imgName: "visitordiscover_image_message", lblTxt: "登录后，别人评论你的微博，给你发消息，都会在这里收到通知")
        
    }

   
}

//
//  ProfileViewController.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/10.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitor.setpresentView(imgName: "visitordiscover_image_profile", lblTxt: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
        
    }

}

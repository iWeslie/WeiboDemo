//
//  MainViewController.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/10.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    fileprivate lazy var composeBtn = UIButton(normalImg: "tabbar_compose_icon_add", bgImg: "tabbar_compose_button")            //fileprivate
       
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupComposeBtn()
    }

}


extension MainViewController {
    fileprivate func setupComposeBtn() {
        
        tabBar.addSubview(composeBtn)
        
        composeBtn.center =  CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)                                    //y的坐标
        composeBtn.addTarget(self, action: #selector(composeBtnClicked), for: .touchUpInside)
    }
}

extension MainViewController {
    @objc fileprivate func composeBtnClicked() {                                                                                //@objc fileprivate
        print("composeBtnClicked")
    }
}


//
//  BaseViewController.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/10.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import  UIKit

class BaseViewController: UITableViewController {
    
    lazy var visitor = VisitorView.loadVisitorView()
    
    var isLogin: Bool = UserInfoViewModel.shareInstace.isLogin
    
    override func loadView() {
        super.loadView()
        
        return
            isLogin ? super.loadView() : setVisitorView()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visitor.rotationImg.isHidden = true
        setNavigationItems()
        
    }
    
    
}

extension BaseViewController {
    fileprivate func setVisitorView() {
        
        view = visitor
        
        visitor.registerBtn.addTarget(self, action: #selector(registerBtnClicked), for: .touchUpInside)
        visitor.loginBtn.addTarget(self, action: #selector(loginBtnClicked), for: .touchUpInside)
        
    }
    
    fileprivate func setNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerBtnClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: .plain, target: self, action: #selector(loginBtnClicked))
    }
    
}

extension BaseViewController {
    @objc fileprivate func registerBtnClicked() {
        print("registerBtnClick")
    }
    
    @objc fileprivate func loginBtnClicked() {
        
        let oauthVC = OAuthViewController()
        let oauthNav = UINavigationController(rootViewController: oauthVC)
        
        present(oauthNav, animated: true, completion: nil)
    }
    
}

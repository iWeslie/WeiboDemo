//
//  OAuthViewController.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/19.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {
    
    @IBOutlet weak var OAuthWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setOAuthVCItems()
        loadOAuthView()
    }
}


extension OAuthViewController {
    fileprivate func setOAuthVCItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(backBtnClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(fillBtnClicked))
        
        title = "授权登陆"
    }
    
    fileprivate func loadOAuthView() {
        
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        OAuthWebView.loadRequest(request)
    }
}

extension OAuthViewController {
    @objc fileprivate func backBtnClicked() {
        dismiss(animated: true, completion: nil)
    }
    @objc fileprivate func fillBtnClicked() {
        
        let jsCode = "document.getElementById('userId').value='2623032659@qq.com';"
        OAuthWebView.stringByEvaluatingJavaScript(from: jsCode)
    }
}

extension OAuthViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
        print(error)
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = request.url else {
            return true
        }
        let urlString = url.absoluteString
        guard urlString.contains("code=") else {
            return true
        }
        
        let code = urlString.components(separatedBy: "code=").last!
        
        loadAccessToken(code)
        
        return false
    }
}

extension OAuthViewController {
    
     func loadAccessToken(_ code : String) {
        NetworkTools.shareInstance.loadAccessToken(code: code) { (result, error) -> () in
            if error != nil {
                print(error ?? "access token not exist")
                return
            }
            guard let accountDict = result else {
                print("没有获取授权后的数据")
                return
            }
            let account = UserInfo(dict: accountDict)
            
            self.loadUserInfo(account: account)
            
        }
        
    }
    
    
    func loadUserInfo(account: UserInfo) {
        
        guard let accesstoken = account.access_token else {
            return
        }
        
        guard let uid = account.uid else {
            return
        }
        
        NetworkTools.shareInstance.loadUserInfo(access_token: accesstoken, uid: uid) { (result, error) in
            if error != nil {
                print(error ?? "load userinfo failed")
                return
            }
            
            guard let userInfoDict = result else {
                return
            }
            
            account.screen_name = userInfoDict["screen_name"] as? String
            account.avatar_hd = userInfoDict["avatar_hd"] as? String
            
            NSKeyedArchiver.archiveRootObject(account, toFile: UserInfoViewModel.shareInstace.accountPath)
            
            UserInfoViewModel.shareInstace.account = account
            
            self.dismiss(animated: false, completion: { 
                UIApplication.shared.keyWindow?.rootViewController = WelcomeViewController()
            })
        }
        
    }

}


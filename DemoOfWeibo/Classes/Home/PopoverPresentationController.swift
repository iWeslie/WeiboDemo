//
//  PopoverPresentationController.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/14.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
    
    
    fileprivate lazy var coverView = UIView()

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView?.frame = CGRect(x: 100, y: 55, width: 180, height: 250)
        
        setupCoverView()
        
        
        
    }
    
}


extension PopoverPresentationController {
    
    func setupCoverView() {
        
        containerView?.insertSubview(coverView, at: 0)
        
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        coverView.frame = containerView!.bounds
        
        let singalTapOnCoverView = UITapGestureRecognizer(target: self, action: #selector(coverViewTap))
        
        coverView.addGestureRecognizer(singalTapOnCoverView)
        
    }
    
    
}

extension PopoverPresentationController {
    @objc fileprivate func coverViewTap() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HomeViewController"), object: nil, userInfo: nil)
        presentedViewController.dismiss(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeArrowDirection"), object: nil, userInfo: ["success": "true"])

    }
    
    
}

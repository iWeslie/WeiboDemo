//
//  VisitorView.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/10.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    
    @IBOutlet weak var rotationImg: UIImageView!
    @IBOutlet weak var presentImg: UIImageView!
    @IBOutlet weak var detialLbl: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    
    
    class func loadVisitorView() -> VisitorView {
        
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)!.first as! VisitorView
    }
    
    
    func loadRotationImg() {
        // 1.创建动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        // 2.设置动画的属性
        rotationAnim.fromValue = 0
        rotationAnim.toValue = Double.pi * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 5
        rotationAnim.isRemovedOnCompletion = false
        
        // 3.将动画添加到layer中
        rotationImg.layer.add(rotationAnim, forKey: nil)
    }
    
    
    
   
    func setpresentView(imgName: String, lblTxt: String) {
        presentImg.image = UIImage(named: imgName)
        detialLbl.text = lblTxt
        

    }
    
    
   
}


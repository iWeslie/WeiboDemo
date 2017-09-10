//
//  StatusesViewModel.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/28.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class StatusViewModel: NSObject {
    
    var status: Status?
    
    var sourceText: String?
    var createAtText: String?
    var verifiedImage: UIImage?
    var vipImage: UIImage?
    var profileURL: URL?
    var picURLs: [URL] = [URL]()
    
    
    
    init(status: Status) {
        self.status = status
        
        if let source = status.source, source != "" {
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startIndex
        
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
        
        if let createAt = status.created_at {
            createAtText = Date.createDateString(createAt)
        }
        
        let verified_type = status.user?.verified_type ?? -1
        
        switch verified_type {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }
        
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank <= 6 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        
        let profileURLString = status.user?.profile_image_url ?? ""
        profileURL = URL(string: profileURLString)
    
        let picurlDicts = status.pic_urls!.count != 0 ? status.pic_urls : status.retweeted_status?.pic_urls
        if let picurlDicts = picurlDicts {
            for picurl in picurlDicts {
                guard let url = picurl["thumbnail_pic"] else {
                    continue
                }
                let picurl = URL(string: url)
                picURLs.append(picurl!)
            }
        }
    }
}

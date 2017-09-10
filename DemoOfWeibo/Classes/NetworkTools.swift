//
//  NetworkTools.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/19.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import AFNetworking

enum RequestMethod: String {
    case get = "get"
    case post = "post"
}

class NetworkTools: AFHTTPSessionManager {
    
    static let shareInstance: NetworkTools = {
        let tools = NetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    }()
    
    
}

extension NetworkTools {

    typealias requestCallbackType = (_ result: AnyObject?, _ error: Error?) -> ()
    
    func request(method: RequestMethod, urlString: String, parameters: Any?, finished: @escaping requestCallbackType) {
        
        
        let successCallback = { (task:  URLSessionDataTask, result: Any?) in
            finished(result as AnyObject, nil)
        }
        
        let failureCallback = { (task:  URLSessionDataTask?, error: Error) in
            finished(nil, error)
        }
        
        if method == .get{
            get(urlString, parameters: parameters, progress: nil, success: successCallback, failure: failureCallback)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: successCallback, failure: failureCallback)
        }
    }
}

extension NetworkTools {
    
    func loadAccessToken(code: String, finished: @escaping (_ result: [String : AnyObject]?, _ error : Error?) -> ()){
        
        let urlString = "https://api.weibo.com/oauth2/access_token"

        let parameters = ["client_id" : app_key, "client_secret" : app_secret, "grant_type" : "authorization_code", "redirect_uri" : redirect_uri, "code" : code]

        request(method: .post, urlString: urlString, parameters: parameters) { (result, error) -> () in
            finished(result as? [String : AnyObject], error)
        }
    }
}

extension NetworkTools {
    func loadUserInfo(access_token: String, uid: String, finished: @escaping (_ result: [String: AnyObject]?, _ error: Error?) -> ()) {
        let url = "https://api.weibo.com/2/users/show.json"
        
        let parameters = ["access_token": access_token, "uid": uid]
        
        request(method: .get, urlString: url, parameters: parameters) { (result, error) in
            finished(result as? [String : AnyObject], error)
        }
    }
}

extension NetworkTools {
    func loadStatuses(finished: @escaping (_ result: [[String: AnyObject]]?, _ error: Error?) -> ()) {
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        let parameters = ["access_token": (UserInfoViewModel.shareInstace.account?.access_token)!]
//        print(parameters["access_token"])
        
        request(method: .get, urlString: url, parameters: parameters) { (result, error) in
            
            if error != nil {
                print(error ?? "loadStatuses failed")
                return
            }
            guard let resultDict = result as? [String: AnyObject] else {
                finished(nil, error)
                return
            }
            
            finished(resultDict["statuses"] as? [[String: AnyObject]], nil)
        }
    }
}

extension NetworkTools {
    
}

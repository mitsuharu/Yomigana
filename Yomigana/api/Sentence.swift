//
//  Sentence.swift
//  Yomigana
//
//  Created by Mitsuhau Emoto on 2019/07/03.
//  Copyright © 2019 Mitsuharu Emoto. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/// 文字列の管理および読み仮名の取得
class Sentence: NSObject {
    var text: String? = nil
    var converted: String? = nil
    var uuid = NSUUID().uuidString
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    
    init(_ text:String? = nil) {
        if let text = text, text.count > 0{
            self.text = text
        }
    }
    
    func toHiragana(completion: @escaping (Bool, ErrorType?)->() )
    {
        guard let text = text, text.count > 0 else {
            return completion(false, .validation)
        }
        
        let url = "https://labs.goo.ne.jp/api/hiragana"
        let apiKey = "6edb2b8ac6c4115f3a088f43a1103a1f08e871c70196ba80c2bd8a93fb93f0ff"
        let headers: HTTPHeaders = [
            "Contenttype": "application/json"
        ]
        let parameters:[String: Any] = [
            "app_id": apiKey,
            "request_id": uuid,
            "sentence": text,
            "output_type": "hiragana"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            if response.result.isFailure {
                var errorType: ErrorType = .unknown
                if let error = response.error{
                    switch (error._code){
                    case NSURLErrorTimedOut:
                        errorType = .timeOut
                    case NSURLErrorNotConnectedToInternet:
                        errorType = .networkOff
                    default:
                        errorType = .unknown
                    }
                }
                return completion(false, errorType)
            }
            
            guard let result = response.result.value else {
                return completion(false, .unknown)
            }
            
            let json = JSON(result)
            if let hira = json["converted"].string, hira.count > 0{
                self.converted = hira
                self.updatedAt = Date()
                return completion(true, nil)
            }
            return completion(false, .unknown)
        }
    }

}



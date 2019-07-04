//
//  AppParam.swift
//  Yomigana
//
//  Created by Mitsuharu Emoto on 2019/07/04.
//  Copyright © 2019 Mitsuharu Emoto. All rights reserved.
//

import UIKit

fileprivate class AppParamKey{
    static let convertedWithEnterKey = "convertedWithEnterKey"
}

/// アプリの設定パラメータ
class AppParam: NSObject {
    
    private let ud = UserDefaults.standard
    
    /// エンターキーで変換するかどうか
    var isConvertedWithEnterKey: Bool{
        get{
            return ud.bool(forKey: AppParamKey.convertedWithEnterKey)
        }
        set(p){
            ud.set(p, forKey: AppParamKey.convertedWithEnterKey)
        }
    }
    
    override init() {
        super.init()
        ud.register(defaults: [AppParamKey.convertedWithEnterKey : false])
    }
    

}

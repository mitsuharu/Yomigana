//
//  Constants.swift
//  Yomigana
//
//  Created by Mitsuharu Emoto on 2019/07/03.
//  Copyright © 2019 Mitsuharu Emoto. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    class App: NSObject{
        static let title = "読み仮名に変換します"
        static let setting = "設定"
    }
    
    class Setting: NSObject{
        static let function = "機能"
        static let license = "ライセンス"
        static let convertedWithEnterKey = "エンターキーでも変換する"
        static let gooUrl = "http://www.goo.ne.jp/"
    }
    
    class Alert: NSObject{
        static let title = "エラー"
        static let ok = "OK"
        static let validation = "入力文が空です"
        static let failed = "読み仮名の取得に失敗しました"
        static let network = "ネットワークに接続できません"
        static let timeout = "タイムアウトしました"
    }

}

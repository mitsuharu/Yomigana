//
//  ViewController.swift
//  Yomigana
//
//  Created by Mitsuharu Emoto on 2019/07/03.
//  Copyright © 2019 Mitsuharu Emoto. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let sentence = Sentence("天気です")
        sentence.toHiragana { (result, errorType) in
            if let errorType = errorType{
                print(errorType.description)
            }
            if result == true, let str = sentence.converted{
                print("converted:", str)
            }
        }
    }


}


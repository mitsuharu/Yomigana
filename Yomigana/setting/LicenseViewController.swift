//
//  LicenseViewController.swift
//  Yomigana
//
//  Created by Mitsuharu Emoto on 2019/07/04.
//  Copyright © 2019 Mitsuharu Emoto. All rights reserved.
//

import UIKit

/// ライセンスを個別に表示する
class LicenseViewController: UIViewController {

    var name: String? = nil
    var body: String? = nil
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
        self.textView.text = body
    }
}

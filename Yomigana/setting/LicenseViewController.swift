//
//  LicenseViewController.swift
//  Yomigana
//
//  Created by Mitsuharu Emoto on 2019/07/04.
//  Copyright © 2019 Mitsuharu Emoto. All rights reserved.
//

import UIKit

class LicenseViewController: UIViewController {

    var name: String? = nil
    var body: String? = nil
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = name
        self.textView.text = body
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

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

    // sentence
    var sentences: [Sentence] = [Sentence]()
    
    // ui
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Constants.Main.title
        self.setupTextView()
        self.setupTableView()
    }
}

extension ViewController{
    
    func addSentence(text: String, completion:@escaping (Bool)->()){
        let sentence = Sentence(text)
        SVProgressHUD.show()
        sentence.toHiragana { (result, errorType) in
            SVProgressHUD.dismiss()
            if result{
                self.sentences.append(sentence)
                self.tableView.reloadData()
            }else{
                let av = UIAlertController(title: Constants.Alert.title,
                                           message: errorType?.description,
                                           preferredStyle: UIAlertController.Style.alert)
                av.addAction(UIAlertAction(title: Constants.Alert.ok,
                                           style: UIAlertAction.Style.default,
                                           handler: nil))
                self.present(av, animated: true, completion: nil)
            }
            completion(result)
        }
    }
}

extension ViewController: UITextViewDelegate{
    
    func setupTextView(){
        textView.text = nil
        textView.returnKeyType = UIReturnKeyType.done
        textView.delegate = self
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool
    {
        if text == "\n" {
            textView.endEditing(true)
            self.addSentence(text: textView.text) { (result) in
                if result{
                    textView.text = nil
                }
            }
            return false
        }
        return true
    }
    
}


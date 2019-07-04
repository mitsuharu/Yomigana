//
//  ViewController.swift
//  Yomigana
//
//  Created by Mitsuharu Emoto on 2019/07/03.
//  Copyright © 2019 Mitsuharu Emoto. All rights reserved.
//

import UIKit
import MEOKit
import SVProgressHUD

class ViewController: UIViewController {

    let appParam = AppParam()
    
    // sentence
    var sentences: [Sentence] = [Sentence]()
    
    // ui
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var cnvButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.setupTextView()
        self.setupTableView()
    }
}

extension ViewController{
    
    func setup(){
        
        self.roundView.layer.cornerRadius = 5
        self.roundView.layer.masksToBounds = true
        
        let size = CGSize(width: 10, height: 10)
        let nImage = UIImage(squareOf: UIColor(hexCode: "dddddd"),
                                  size: size)
        let hImage = UIImage(squareOf: UIColor(hexCode: "aaaaaa"),
                                  size: size)
        
        self.cnvButton.layer.cornerRadius = 5
        self.cnvButton.layer.masksToBounds = true
        self.cnvButton.backgroundColor = UIColor.clear
        self.cnvButton.setBackgroundImage(nImage, for: .normal)
        self.cnvButton.setBackgroundImage(hImage, for: .highlighted)
        
        self.title = Constants.App.title
        
        let item = UIBarButtonItem(title: Constants.App.setting,
                                   style: UIBarButtonItem.Style.plain,
                                   target: self,
                                   action: #selector(pushSetting(_:)))
        self.navigationItem.rightBarButtonItem = item
    }
    
    @objc func pushSetting(_ sender: UIBarButtonItem) {
        let vc = SettingViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapCnvButton(buttn: UIButton){
        self.textView.endEditing(true)
        self.cnvButton.isUserInteractionEnabled = false
        self.addSentence(text: self.textView.text) { (result) in
            self.cnvButton.isUserInteractionEnabled = true
            if result{
                self.textView.text = nil
                self.placeholderLabel.isHidden = false
            }
        }
    }
    
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
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        placeholderLabel.isHidden = true
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            placeholderLabel.isHidden = false
        }
    }
    
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool
    {
        if text == "\n"  {
            textView.endEditing(true)
            
            if appParam.isConvertedWithEnterKey{
                self.addSentence(text: textView.text) { (result) in
                    if result{
                        textView.text = nil
                    }
                }
            }
            return false
        }
        return true
    }
    
}


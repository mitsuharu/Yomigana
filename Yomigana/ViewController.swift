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

/// アプリのメインです
class ViewController: UIViewController {

    // パラメータ
    let appParam = AppParam()
    
    // sentence array
    var sentences: [Sentence] = [Sentence]()
    
    var isRequesting: Bool = false
    var cellHeights: [IndexPath: CGFloat] = [IndexPath: CGFloat]()
    
    // ui
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var cnvButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUIs()
        self.setupTextView()
        self.setupTableView()
    }
}

extension ViewController{
    
    /// UI群の基本設定を行う
    func setupUIs(){
        
        SVProgressHUD.setDefaultStyle(.dark)

        self.roundView.layer.cornerRadius = 5
        self.roundView.layer.masksToBounds = true
        
        let size = CGSize(width: 1, height: 1)
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
        
        if self.isRequesting{
            return
        }
        
        self.textView.endEditing(true)
        self.addSentence(text: self.textView.text) { (_) in
        }
    }
    
    /// 読み仮名に変更して結果一覧に表示する
    func addSentence(text: String, completion:@escaping (Bool)->()){
        
        self.isRequesting = true
        SVProgressHUD.show()
        
        let sentence = Sentence(text)
        sentence.toHiragana { (result, errorType) in
            SVProgressHUD.dismiss()
            if result{
                self.sentences.insert(sentence, at: 0)

                let ips = [IndexPath(row: 0, section: 0)]
                self.tableView.insertRows(at: ips, with: .automatic)
                
                self.textView.text = nil
                if self.textView.isFirstResponder && self.appParam.isConvertedWithEnterKey {
                    self.placeholderLabel.isHidden = true
                }else{
                    self.placeholderLabel.isHidden = false
                }
                
            }else if let err = errorType{
                let av = UIAlertController(title: Constants.Alert.title,
                                           message: err.description,
                                           preferredStyle: UIAlertController.Style.alert)
                av.addAction(UIAlertAction(title: Constants.Alert.ok,
                                           style: UIAlertAction.Style.default,
                                           handler: nil))
                self.present(av, animated: true, completion: nil)
            }
            
            self.isRequesting = false
            completion(result)
        }
    }
}

extension ViewController: UITextViewDelegate{
    
    func setupTextView(){
        self.textView.text = nil
        self.textView.delegate = self
        
        let rect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40)
        let toolBar = UIToolbar(frame: rect)
        toolBar.barStyle = UIBarStyle.default
        toolBar.sizeToFit()
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: nil,
                                     action: nil)
        let closeBtn = UIBarButtonItem(title: Constants.App.closeKeyboard,
                                       style: UIBarButtonItem.Style.plain,
                                       target: self,
                                       action: #selector(closeKeyboard(_ :)) )
        toolBar.items = [spacer, closeBtn]
        self.textView.inputAccessoryView = toolBar
    }
    
    @objc func closeKeyboard(_ sender: AnyObject) {
        if self.textView.isFirstResponder{
            self.textView.resignFirstResponder()
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        self.placeholderLabel.isHidden = true
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.placeholderLabel.isHidden = false
        }
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool
    {
        if self.isRequesting{
            return false
        }
        if text == "\n" && self.appParam.isConvertedWithEnterKey {
            self.addSentence(text: textView.text) { (_) in
            }
            return false
        }
        return true
    }
    
}


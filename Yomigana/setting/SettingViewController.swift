//
//  SettingViewController.swift
//  Yomigana
//
//  Created by Mitsuharu Emoto on 2019/07/04.
//  Copyright © 2019 Mitsuharu Emoto. All rights reserved.
//

import UIKit
import SafariServices
import MEOKit

class SettingViewController: UIViewController {

    let appParam = AppParam()
    var licenses: [[String : String]] = [[String : String]]()
    
    // ui
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "設定"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let plistPath = Bundle.main.path(forResource: "Licenses", ofType:"plist")
        licenses = NSArray(contentsOfFile: plistPath!)! as! [[String : String]]
        licenses.sort { (temp0, temp1) -> Bool in
            guard
                let title0: String = temp0["title"],
                let title1: String = temp1["title"]
                else{
                    return false
            }
            return title0 < title1
        }
       
    }
}

extension SettingViewController{
    
    @IBAction func didTapGooButton(sender: UIButton){
        if let url = URL(string: "http://www.goo.ne.jp/") {
            let vc = SFSafariViewController(url: url)
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        }else{
            return self.licenses.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "機能"
        }else{
            return "ライセンス"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "basic", for: indexPath)
        cell.textLabel?.text = nil
        
        if indexPath.section == 0{
            cell.selectionStyle = .none
            if indexPath.row == 0{
                cell.textLabel?.text = "エンターキーでも変換する"
                cell.meo.addSwitch(isOn: appParam.isConvertedWithEnterKey) { (_, sw) in
                    self.appParam.isConvertedWithEnterKey = sw.isOn
                }
            }
            
        }else{
            cell.selectionStyle = .default
            if let license = licenses[safe: indexPath.row]{
                cell = tableView.dequeueReusableCell(withIdentifier: "indicator",
                                                     for: indexPath)
                cell.textLabel?.text = license["title"]
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0{
            
        }else{
            if let license = licenses[safe: indexPath.row]{
                let vc: LicenseViewController = self.storyboard?.instantiateViewController(withIdentifier: "LicenseViewController") as! LicenseViewController
                vc.name = license["title"]
                vc.body = license["text"]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}

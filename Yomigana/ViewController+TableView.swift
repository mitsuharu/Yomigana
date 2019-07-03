//
//  ViewController+TableView.swift
//  Yomigana
//
//  Created by Mitsuhau Emoto on 2019/07/03.
//  Copyright © 2019 Mitsuharu Emoto. All rights reserved.
//

import UIKit
import MEOKit

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func setupTableView(){
        tableView.register(UINib(nibName: "SentenceCell", bundle: Bundle.main),
                           forCellReuseIdentifier: "SentenceCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sentences.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentenceCell",
                                                 for: indexPath)
        
        if
            let scell: SentenceCell = cell as? SentenceCell,
            let sentence = self.sentences[safe: indexPath.row]
        {
            scell.sentence = sentence
            scell.setContents()
        }
        
        return cell
    }
    
    
}


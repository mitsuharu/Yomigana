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
        self.tableView.meo.registerCell(className: "SentenceCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return self.sentences.count
    }
    
    func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        guard let height = self.cellHeights[indexPath] else {
            return UITableView.automaticDimension
        }
        return height
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath)
    {
        if let _ = self.cellHeights[indexPath]{
            self.cellHeights[indexPath] = cell.frame.height
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentenceCell",
                                                 for: indexPath)
        cell.separatorInset = UIEdgeInsets.zero
        
        if
            let scell: SentenceCell = cell as? SentenceCell,
            let sentence = self.sentences[safe: indexPath.row]
        {
            scell.sentence = sentence
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard
            let sentence = self.sentences[safe: indexPath.row],
            let text = sentence.converted
        else {
            return
        }
        
        let vc = UIActivityViewController(activityItems: [text],
                                          applicationActivities: nil)
        vc.excludedActivityTypes = [
            .postToVimeo,
            .postToWeibo,
            .postToFlickr,
            .saveToCameraRoll,
            .print,
        ]
        self.present(vc, animated: true, completion: nil)
    }
}


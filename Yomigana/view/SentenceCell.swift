//
//  SentenceCell.swift
//  Yomigana
//
//  Created by Mitsuhau Emoto on 2019/07/03.
//  Copyright © 2019 Mitsuharu Emoto. All rights reserved.
//

import UIKit

class SentenceCell: UITableViewCell {

    var sentence:Sentence!
    
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var rawLabel:UILabel!
    @IBOutlet weak var yomiLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContents(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        self.dateLabel.text = dateFormatter.string(from: sentence.updatedAt)
        self.rawLabel.text = sentence.text
        self.yomiLabel.text = sentence.converted
    }
    
}

//
//  MessageCellTableViewCell.swift
//  SwapMe
//
//  Created by Rao Mudassar on 08/11/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class MessageCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var notes_title: UILabel!
       
       @IBOutlet weak var notes_des: UILabel!
    @IBOutlet weak var message_count: UILabel!
    
    
    @IBOutlet var messagedetailLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        message_count.layer.cornerRadius = message_count.frame.height/2
        message_count.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  HistoryTableViewCell.swift
//  SwapMe
//
//  Created by Rao Mudassar on 18/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_history: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  NotesTableViewCell.swift
//  SwapMe
//
//  Created by Rao Mudassar on 05/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var notes_title: UILabel!
    
    @IBOutlet weak var notes_des: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

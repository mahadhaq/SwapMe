//
//  MatchTableViewCell.swift
//  SwapMe
//
//  Created by Rao Mudassar on 25/10/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var user1_title: UILabel!
    
    
    @IBOutlet weak var user2_image: UIImageView!
    
    @IBOutlet weak var user1_image: UIImageView!
    
    @IBOutlet weak var user2_title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

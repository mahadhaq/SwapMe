//
//  TableViewCell01.swift
//  WOW
//
//  Created by Rao Mudassar on 14/04/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class TableViewCell01: UITableViewCell {
    
    @IBOutlet weak var profile_img: UIImageView!
    
    @IBOutlet weak var profile_name: UILabel!
    
    @IBOutlet weak var profile_email: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

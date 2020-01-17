//
//  TableViewCell03.swift
//  SwapMe
//
//  Created by Rao Mudassar on 23/10/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class TableViewCell03: UITableViewCell {
    
    @IBOutlet weak var menu_name: UILabel!
    
    @IBOutlet weak var gen_view: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

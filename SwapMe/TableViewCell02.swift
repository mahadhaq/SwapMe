//
//  TableViewCell02.swift
//  WOW
//
//  Created by Rao Mudassar on 14/04/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class TableViewCell02: UITableViewCell {
    
    @IBOutlet weak var gen_view: UIView!
    
    @IBOutlet weak var lbl_gen: UILabel!
    
    @IBOutlet weak var menu_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

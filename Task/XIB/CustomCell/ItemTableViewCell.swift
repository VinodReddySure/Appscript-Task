//
//  ItemTableViewCell.swift
//  Task
//
//  Created by Vinod Reddy Sure on 17/12/20.
//  Copyright © 2020 Vinod Reddy Sure. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var labelItemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  DashTableViewCell.swift
//  MyPR
//
//  Created by Peter Gelsomino on 1/25/19.
//  Copyright © 2019 PeteGels. All rights reserved.
//

import UIKit

class DashTableViewCell: UITableViewCell {

    @IBOutlet weak var liftLabel: UILabel!
    @IBOutlet weak var maxLiftLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  LiftHistoryTableViewCell.swift
//  MyPR
//
//  Created by Peter Gelsomino on 9/11/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import UIKit

class LiftHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lbsHistoryLabel: UILabel!
    @IBOutlet weak var repsHistoryLabel: UILabel!
    @IBOutlet weak var dateLiftHistory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  LiftHistoryTableView.swift
//  MyPR
//
//  Created by Peter Gelsomino on 9/11/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import UIKit

class LiftHistoryTableView: UITableView {

    var lifts = [Lift]()
    
    override func numberOfRows(inSection section: Int) -> Int {
        return lifts.count
    }
    
}

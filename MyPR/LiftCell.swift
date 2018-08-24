//
//  Lift.swift
//  ReachPR
//
//  Created by Peter Gelsomino on 8/14/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import Foundation
import UIKit

class LiftCell {
    var name: String
    var maxLift: Int
    var liftImage: UIImage
    var liftDate: String
    
    init?(name: String, maxLift: Int, liftImage: UIImage, liftDate: String) {
        self.name = name
        self.maxLift = maxLift
        self.liftImage = liftImage
        self.liftDate = liftDate
    }
    
}

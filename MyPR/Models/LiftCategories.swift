//
//  LiftCategories.swift
//  MyPR
//
//  Created by Peter Gelsomino on 10/9/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import Foundation

// MARK: Variables
struct LiftObjects {
    var liftSectionName: String
    var liftSectionObjects: [String]
}

struct LiftObjectsArray {
    var liftObjectsArray = [
        LiftObjects(liftSectionName: "Squat", liftSectionObjects: ["Back Squat", "Front Squat", "Hack Squat"]),
        LiftObjects(liftSectionName: "Clean", liftSectionObjects: ["Clean", "Full Power", "Hang Power", "Power"]),
        LiftObjects(liftSectionName: "Snatch", liftSectionObjects: ["Muscle", "Full Power", "Hang Power"])
    ]
}

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
        LiftObjects(liftSectionName: "Squat", liftSectionObjects: ["Back Squat", "Front Squat", "Hack Squat", "Overhead Squat", "Split Squat"]),
        LiftObjects(liftSectionName: "Clean", liftSectionObjects: ["Hang Clean", "Squat Hang Clean", "Power Clean", "Squat Power Clean", "Muscle Clean" ]),
        LiftObjects(liftSectionName: "Snatch", liftSectionObjects: ["Muscle Snatch", "Squat Power Snatch", "Hang Power Snatch"]),
        LiftObjects(liftSectionName: "Presses", liftSectionObjects: ["Bench Press", "Floor Press", "Push Press", "Shoulder Press"]),
        LiftObjects(liftSectionName: "Jerks", liftSectionObjects: ["Push Jerk", "Split Jerk", "Squat Jerk"]),
        LiftObjects(liftSectionName: "Other", liftSectionObjects: ["DeadLift", "Clean & Jerk", "Power Clean & Jerk"])
    ]
}

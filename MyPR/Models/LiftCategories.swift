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
        LiftObjects(liftSectionName: "Snatch", liftSectionObjects: ["Muscle Snatch", "Squat Snatch", "Hang Squat Snatch", "Power Snatch"]),
        LiftObjects(liftSectionName: "Presses", liftSectionObjects: ["Bench Press", "Dumbell Bench Press",  "Incline Bench Press", "Dumbell Incline Bench Press", "Decline Bench Press", "Dumbell Floor Press", "Push Press", "Barbell Shoulder Press", "Dumbell Shoulder Press"]),
        LiftObjects(liftSectionName: "Jerks", liftSectionObjects: ["Push Jerk", "Split Jerk", "Squat Jerk"]),
        LiftObjects(liftSectionName: "Clean", liftSectionObjects: ["Hang Clean", "Power Clean", "Hang Squat Clean", "Squat Clean", "Hang Power Clean", "Muscle Clean"]),
        LiftObjects(liftSectionName: "Other", liftSectionObjects: ["Deadlift", "Stiff-Legged Deadlift","Clean & Jerk", "Power Clean & Jerk"])
    ]
}

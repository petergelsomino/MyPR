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
    
    func populateObjectsArray(reading: String) -> [LiftObjects]  {
        
        switch reading {
        case "lift":
            break
        case "endurance":
            return getEnduranceObjectsArray()
        default:
            return getEnduranceObjectsArray()
        }
        return []
    }
    
    func getEnduranceObjectsArray() -> [LiftObjects] {
        var array:[LiftObjects] = []
        for type in EnduranceType.allCases {
            print(type.displayText)
            let object = LiftObjects(liftSectionName: type.displayText, liftSectionObjects: returnSectionEndurances(enduranceType: type.displayText))
            array.append(object)
        }
        return array
    }
    
    func getliftsObjectsArray() -> [LiftObjects] {
        var array:[LiftObjects] = []
        for type in LiftType.allCases {
            print(type.displayText)
            let object = LiftObjects(liftSectionName: type.displayText, liftSectionObjects: returnSectionEndurances(enduranceType: type.displayText))
            array.append(object)
        }
        return array
    }
    
    func returnSectionEndurances(enduranceType: String) -> [String] {
        switch enduranceType {
        case "Run":
            return returnRunningDistances()
        case "Row":
            return returnRowingDistances()
        default:
            return []
        }
    }
    
    func returnRunningDistances() -> [String] {
        var array:[String] = []
        for distance in ImperialDistance.allCases {
            print(distance.displayText)
            array.append(distance.displayText)
        }
        return array
    }
    
    func returnRowingDistances() -> [String] {
        var array:[String] = []
        for calories in CalorieDistance.allCases {
            print(calories.displayText)
            array.append(calories.displayText)
        }
        for meters in MetricDistance.allCases {
            print(meters.displayText)
            array.append(meters.displayText)
        }
        return array
    }
}

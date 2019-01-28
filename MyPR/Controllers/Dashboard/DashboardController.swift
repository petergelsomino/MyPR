//
//  DashboardController.swift
//  MyPR
//
//  Created by Peter Gelsomino on 1/27/19.
//  Copyright © 2019 PeteGels. All rights reserved.
//

import Foundation

// MARK: Variables
struct LiftObjects {
    var liftSectionName: String
    var liftSectionObjects: [String]
}

struct LiftObjectsArray {
    
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
            let object = LiftObjects(liftSectionName: type.displayText, liftSectionObjects: returnSectionLifts(enduranceType: type.displayText))
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
    
    func returnSectionLifts(enduranceType: String) -> [String] {
        switch enduranceType {
        case "Squat":
            return getSquatLifts()
        case "Snatch":
            return getSnatchLifts()
        case "Press":
            return getPressLifts()
        case "Jerk":
            return getJerkLifts()
        case "Clean":
            return getCleanLifts()
        case "Other":
            return getOtherLifts()
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
    
    func getSquatLifts() -> [String] {
        var array:[String] = []
        for squats in Squat.allCases {
            print(squats.displayText)
            array.append(squats.displayText)
        }
        return array
    }
    
    func getPressLifts() -> [String] {
        var array:[String] = []
        for presses in Press.allCases {
            print(presses.displayText)
            array.append(presses.displayText)
        }
        return array
    }
    
    func getJerkLifts() -> [String] {
        var array:[String] = []
        for jerks in Jerk.allCases {
            print(jerks.displayText)
            array.append(jerks.displayText)
        }
        return array
    }
    
    func getOtherLifts() -> [String] {
        var array:[String] = []
        for others in Other.allCases {
            print(others.displayText)
            array.append(others.displayText)
        }
        return array
    }
    
    func getCleanLifts() -> [String] {
        var array:[String] = []
        for cleans in Clean.allCases {
            print(cleans.displayText)
            array.append(cleans.displayText)
        }
        return array
    }
    
    func getSnatchLifts() -> [String] {
        var array:[String] = []
        for snatches in Snatch.allCases {
            print(snatches.displayText)
            array.append(snatches.displayText)
        }
        return array
    }
}

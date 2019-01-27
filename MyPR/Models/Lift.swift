//
//  Lift.swift
//  ReachPR
//
//  Created by Peter Gelsomino on 8/14/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

struct Lift {
    
    let ref: DatabaseReference?
    let key: String
    let name: String
    let maxLift: Int
    let liftDate: String
    let reps: Int
    let recordedByUser: String
    
    init(name: String, maxLift: Int, liftDate: String, key: String = "", reps: Int, recordedByUser: String) {
        self.ref = nil
        self.key = key
        self.name = name
        self.maxLift = maxLift
        self.liftDate = liftDate
        self.reps = reps
        self.recordedByUser = recordedByUser
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let maxLift = value["maxLift"] as? Int,
            let liftDate = value["liftDate"] as? String,
            let reps =  value["reps"] as? Int,
            let recordedByUser = value["recordedByUser"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.maxLift = maxLift
        self.liftDate = liftDate
        self.reps = reps
        self.recordedByUser = recordedByUser
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "maxLift": maxLift,
            "liftDate": liftDate,
            "reps": reps,
            "recordedByUser": recordedByUser
        ]
    }
}

enum LiftType: CaseIterable  {
    case squat
    case snatch
    case press
    case jerk
    case clean
    case other
    
    var displayText: String {
        switch self {
        case .squat: return "Squat"
        case .snatch: return "Snatch"
        case .press: return "Press"
        case .jerk: return "Jerk"
        case .clean: return "Clean"
        case .other: return "Other"
        }
    }
    
    var databaseKey: String {
        switch self {
        case .squat: return "Squat"
        case .snatch: return "Snatch"
        case .press: return "Press"
        case .jerk: return "Jerk"
        case .clean: return "Clean"
        case .other: return "Other"
        }
    }
}

enum Squat {
    case backSquat
    case frontSquat
    case hackSquat
    case overheadSquat
    case splitSquat
    
    var displayText: String {
        switch self {
        case .backSquat: return "Back Squat"
        case .frontSquat: return "Front Squat"
        case .hackSquat: return "Hack Squat"
        case .overheadSquat: return "Overhead Squat"
        case .splitSquat: return "Split Squat"
        }
    }
    
    var databaseKey: String {
        switch self {
        case .backSquat: return "backsquat"
        case .frontSquat: return "frontsquat"
        case .hackSquat: return "hacksquat"
        case .overheadSquat: return "Jerk"
        case .splitSquat: return "splitsquat"
        }
    }
}

//LiftObjects(liftSectionName: "Squat", liftSectionObjects: ["Back Squat", "Front Squat", "Hack Squat", "Overhead Squat", "Split Squat"]),
//LiftObjects(liftSectionName: "Snatch", liftSectionObjects: ["Muscle Snatch", "Squat Snatch", "Hang Squat Snatch", "Power Snatch"]),
//LiftObjects(liftSectionName: "Presses", liftSectionObjects: ["Bench Press", "Dumbell Bench Press",  "Incline Bench Press", "Dumbell Incline Bench Press", "Decline Bench Press", "Dumbell Floor Press", "Push Press", "Barbell Shoulder Press", "Dumbell Shoulder Press"]),
//LiftObjects(liftSectionName: "Jerks", liftSectionObjects: ["Push Jerk", "Split Jerk", "Squat Jerk"]),
//LiftObjects(liftSectionName: "Clean", liftSectionObjects: ["Hang Clean", "Power Clean", "Hang Squat Clean", "Squat Clean", "Hang Power Clean", "Muscle Clean"]),
//LiftObjects(liftSectionName: "Other", liftSectionObjects: ["Deadlift", "Stiff-Legged Deadlift","Clean & Jerk", "Power Clean & Jerk"])

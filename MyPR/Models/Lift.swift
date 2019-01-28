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
enum Squat: CaseIterable {
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

enum Snatch: CaseIterable {
    case muscleSnatch
    case hangSquatSnatch
    case powerSnatch
    case squatSnatch
    
    var displayText: String {
        switch self {
        case .muscleSnatch: return "Muscle Snatch"
        case .squatSnatch: return "Squat Snatch"
        case .hangSquatSnatch: return "Hang Squat Snatch"
        case .powerSnatch: return "Power Snatch"
        }
    }
    
    var databaseKey: String {
        switch self {
        case .muscleSnatch: return "musclesnatch"
        case .squatSnatch: return "squatsnatch"
        case .hangSquatSnatch: return "hangsquatsnatch"
        case .powerSnatch: return "powersnatch"
        }
    }
}

enum Press: CaseIterable {
    case benchPress
    case dumbbellBenchPress
    case inclineBenchPress
    case dumbellInclineBenchPress
    case declineBenchPress
    case dumbellFloorPress
    case pushPress
    case barbellStrictPress
    case dumbbellStrictPress
    
    var displayText: String {
        switch self {
        case .benchPress: return "Bench Press"
        case .dumbbellBenchPress: return "Dumbbell Bench Press"
        case .dumbellInclineBenchPress: return "Dumbbell Incline Bench Press"
        case .declineBenchPress: return "Decline Bench Press"
        case .dumbellFloorPress: return "Dumbbell Floor Press"
        case .pushPress: return "Push Press"
        case .barbellStrictPress: return "Barbell Strict Press"
        case .dumbbellStrictPress: return "Dumbbell Strict Press"
        case .inclineBenchPress: return "Incline Bench Press"
        }
    }
    
    var databaseKey: String {
        switch self {
        case .benchPress: return "benchpress"
        case .dumbbellBenchPress: return "dumbbellbenchpress"
        case .dumbellInclineBenchPress: return "dumbbellinclinebenchpress"
        case .declineBenchPress: return "declinebenchpress"
        case .dumbellFloorPress: return "dumbbellfloorpress"
        case .pushPress: return "pushpress"
        case .barbellStrictPress: return "barbellshoulderpress"
        case .dumbbellStrictPress: return "dumbellshoulderpress"
        case .inclineBenchPress: return "inclinebenchpress"
        }
    }
}

enum Jerk: CaseIterable {
    case pushJerk
    case splitJerk
    case squatJerk
    
    var displayText: String {
        switch self {
        case .pushJerk: return "Push Jerk"
        case .splitJerk: return "Split Jerk"
        case .squatJerk: return "Squat Jerk"
        }
    }
    
    var databaseKey: String {
        switch self {
        case .pushJerk: return "pushjerk"
        case .splitJerk: return "splitjerk"
        case .squatJerk: return "squatjerk"
        }
    }
}

enum Clean: CaseIterable {
    case hangClean
    case powerClean
    case hangSquatClean
    case squatClean
    case hangPowerClean
    case muscleClean
    
    var displayText: String {
        switch self {
        case .hangClean: return "Hang Clean"
        case .powerClean: return "Power Clean"
        case .hangSquatClean: return "Hang Squat Clean"
        case .squatClean: return "Squat Clean"
        case .hangPowerClean: return "Hang Power Clean"
        case .muscleClean: return "Muscle Clean"
        }
    }
    
    var databaseKey: String {
        switch self {
        case .hangClean: return "hangclean"
        case .powerClean: return "powerclean"
        case .hangSquatClean: return "hangsquatclean"
        case .squatClean: return "squatclean"
        case .hangPowerClean: return "hangpowerclean"
        case .muscleClean: return "muscleclean"
        }
    }
}

enum Other: CaseIterable {
    case deadlift
    case stiffLeggedDeadlift
    case cleanJerk
    case powerCleanJerk
    
    var displayText: String {
        switch self {
        case .deadlift: return "Deadlift"
        case .stiffLeggedDeadlift: return "Stiff-Legged Deadlift"
        case .cleanJerk: return "Clean & Jerk"
        case .powerCleanJerk: return "Power Clean & Jerk"
        }
    }
    
    var databaseKey: String {
        switch self {
        case .deadlift: return "deadlift"
        case .stiffLeggedDeadlift: return "stiff-leggeddeadlift"
        case .cleanJerk: return "clean&jerk"
        case .powerCleanJerk: return "powerclean&jerk"
        }
    }
}


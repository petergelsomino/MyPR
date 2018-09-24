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
    
    init(name: String, maxLift: Int, liftDate: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.name = name
        self.maxLift = maxLift
        self.liftDate = liftDate
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let maxLift = value["maxLift"] as? Int,
            let liftDate = value["liftDate"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.maxLift = maxLift
        self.liftDate = liftDate
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "maxLift": maxLift,
            "liftDate": liftDate
        ]
    }
}

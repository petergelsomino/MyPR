//
//  Lift.swift
//  ReachPR
//
//  Created by Peter Gelsomino on 8/14/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Lift: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var maxLift: Int = 0
//    @objc dynamic var liftImage: UIImage = UIImage()
    @objc dynamic var liftDate: String = ""
    
//    init?(name: String, maxLift: Int, liftImage: UIImage, liftDate: String) {
//        self.name = name
//        self.maxLift = maxLift
//        self.liftImage = liftImage
//        self.liftDate = liftDate
//    }
    
}

class LiftHostory: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var maxLift: Int = 0
    @objc dynamic var liftDate: String = ""
    let liftHistory = List<Lift>()
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
}

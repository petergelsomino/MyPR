//
//  Endurance.swift
//  MyPR
//
//  Created by Peter Gelsomino on 1/10/19.
//  Copyright © 2019 PeteGels. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Endurance {
    
    let ref: DatabaseReference?
    let key: String
    let enduranceType: EnduranceType
    let name: String
    let time: String
    let enduranceMetric: EnduranceMetric
    let recordedByUser: String
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let enduranceType = value["enduranceType"] as? EnduranceType,
            let enduranceMetric = value["enduranceMetric"] as? EnduranceMetric,
            let name = value["name"] as? String,
            let time = value["time"] as? String,
            let recordedByUser = value["recordedByUser"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.enduranceType = enduranceType
        self.enduranceMetric = enduranceMetric
        self.name = name
        self.time = time
        self.recordedByUser = recordedByUser
    }
    
    func toAnyObject() -> Any {
        return [
            "enduranceType": enduranceType,
            "enduranceMetric": enduranceMetric,
            "name": name,
            "time": time,
            "recordedByUser": recordedByUser
        ]
    }
    
}

enum EnduranceType: CaseIterable {
    
    case run
    case row
    case ski
    case assaultBike
    case echoBike
    case bike
    case swim

    var displayText: String {
        switch self {
        case .run: return .run
        case .row: return .row
        case .ski: return .ski
        case .assaultBike: return .assaultBike
        case .echoBike: return .echoBike
        case .bike: return .bike
        case .swim: return .swim
        }
    }
    
    var databaseKey: String {
        switch self {
        case .row: return "Row"
        case .ski: return "Ski"
        case .assaultBike: return "Assult Bike"
        case .echoBike: return "Echo Bike"
        case .bike: return "Bike"
        case .swim: return "Swim"
        case .run: return "Run"
        }
    }
}

enum EnduranceMetric {
    case imperial(ImperialDistance)
    case metric(MetricDistance)
    case calories(CalorieDistance)
}

enum CalorieDistance: CaseIterable {
    case eight
    case ten
    case fifteen
    case twenty
    case thirty
    
    var displayText: String {
        switch self {
        case .eight: return "8 cal"
        case .ten: return "10 cal"
        case .fifteen: return "15 cal"
        case .twenty: return "20 cal"
        case .thirty: return "30 cal"
        }
    }
    
    var databaseKey: String {
        switch self {
        case .eight: return "eightCal"
        case .ten: return "tenCal"
        case .fifteen: return "fifteenCal"
        case .twenty: return "twentyCal"
        case .thirty: return "thirtyCal"
        }
    }
}

enum ImperialDistance: CaseIterable {
    case oneMile
    case threeMiles
    case fiveMiles
    case tenMiles
    case halfMarathon
    case fifteenMiles
    case twentyMiles
    case twentyFiveMiles
    case marathon
    
    var displayText: String {
        switch self {
        case .oneMile: return "1 mi."
        case .threeMiles: return "3 mi."
        case .fiveMiles: return "5 mi."
        case .tenMiles: return "10 mi."
        case .halfMarathon: return "13.1 mi."
        case .fifteenMiles: return "15 mi."
        case .twentyMiles: return "20 mi."
        case .twentyFiveMiles: return "25mi."
        case .marathon: return "26.2 mi."
        }
    }
    
    var databaseKey: String {
        switch self {
        case .oneMile: return "oneMile"
        case .threeMiles: return "threeMiles"
        case .fiveMiles: return "fiveMiles"
        case .tenMiles: return "tenMiles"
        case .halfMarathon: return "halfMarathon"
        case .fifteenMiles: return "fifteenMiles"
        case .twentyMiles: return "twentyMiles"
        case .twentyFiveMiles: return "twentyFiveMiles"
        case .marathon: return "marathon"
        }
    }
}


enum MetricDistance: CaseIterable {
    case fifty
    case oneHundred
    case fourHundred
    case eightHundred
    case oneThousand
    case twoThousand
    case threeThousand
    case fourThousand
    case fiveThousand
    case tenThousand
    
    var displayText: String {
        switch self {
        case .fifty: return "50 m"
        case .oneHundred: return "100 m"
        case .fourHundred: return "400 m"
        case .eightHundred: return "800 m"
        case .oneThousand: return "1000 m"
        case .twoThousand: return "2000 m"
        case .threeThousand: return "3000 m"
        case .fourThousand: return "4000 m"
        case .fiveThousand: return "5000 m"
        case .tenThousand: return "10,000 m"
        }
    }
    
    var databaseKey: String {
        switch self {
        case .fifty: return "fiftyMeters"
        case .oneHundred: return "oneHundredMeters"
        case .fourHundred: return "fourHundredMeters"
        case .eightHundred: return "eightHundredMeters"
        case .oneThousand: return "oneThousandMeters"
        case .twoThousand: return "twoThousandMeters"
        case .threeThousand: return "threeThousandMeters"
        case .fourThousand: return "fourthousandMeters"
        case .fiveThousand: return "fiveThousandMeters"
        case .tenThousand: return "tenThousandMeters"
        }
    }
}




//
//  Extensions.swift
//  MyPR
//
//  Created by Peter Gelsomino on 9/8/18.
//  Copyright © 2018 PeteGels. All rights reserved.
//

import Foundation

extension Date
{
    
    init(dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        let d = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:d)
    }
}

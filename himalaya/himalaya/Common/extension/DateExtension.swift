//
//  DateExtension.swift
//  himalaya
//
//  Created by Farben on 2020/9/1.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation

extension Date {
    
    func getWeekDay() -> Int {
        let interval = Int(self.timeIntervalSince1970) + NSTimeZone.local.secondsFromGMT()
        let days = Int(interval / 86400) // (24 * 60 * 60)
        let weekday = ((days + 4) % 7 + 7) % 7
        let comps = weekday == 0 ? 7 : weekday
        return comps
    }
}

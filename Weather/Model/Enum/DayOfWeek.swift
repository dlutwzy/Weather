//
//  DayOfWeak.swift
//  Weather
//
//  Created by iMac on 2018/5/10.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

enum DayOfWeek: Int {

    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thurday
    case friday
    case saturday

    var stringValue: String {
        switch self {

        case .sunday:
            return "Sun"
        case .monday:
            return "Mon"
        case .tuesday:
            return "Tues"
        case .wednesday:
            return "Wed"
        case .thurday:
            return "Thur"
        case .friday:
            return "Fri"
        case .saturday:
            return "Sat"
        }
    }
}

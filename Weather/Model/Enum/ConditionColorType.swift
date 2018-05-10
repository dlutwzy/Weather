//
//  ConditionColorType.swift
//  Weather
//
//  Created by iMac on 2018/5/8.
//  Copyright © 2018年 iMac. All rights reserved.
//

import UIKit

enum ConditionColorType: Int {
    case level0 = 0 // 81 23 250, 85 28 246
    case level1 // 97 48 249, 91 45 230
    case level2 // 16 90 254, 27 90 233
    case level3 // 53 68 254, 53 67 252
    case level4 // 15 126 247, 14 121 237
    case level5 // 25 93 234, 29 99 233
    case level6 // 67 192 247, 66 192 246
    case level7 // 253 190 58, 248 187 57
    case level8 // 248 62 42, 245 70 47
    case level9 // 245 46 35, 235 45 37

    init?(fahrenheit: CGFloat) {
        let value = min(max(-30, fahrenheit), 69)
        self.init(rawValue: Int(value / 10 + 3.0))
    }

    func colorPackage() -> [UIColor] {

        var ret: [UIColor]
        switch self {

        case .level0:
            ret = [
                UIColor(red: 81, green: 23, blue: 250, alpha: 255),
                UIColor(red: 85, green: 28, blue: 246, alpha: 255)
            ]
        case .level1:
            ret = [
                UIColor(red: 97, green: 48, blue: 249, alpha: 255),
                UIColor(red: 91, green: 45, blue: 230, alpha: 255)
            ]
        case .level2:
            ret = [
                UIColor(red: 16, green: 90, blue: 254, alpha: 255),
                UIColor(red: 27, green: 90, blue: 233, alpha: 255)
            ]
        case .level3:
            ret = [
                UIColor(red: 53, green: 68, blue: 254, alpha: 255),
                UIColor(red: 53, green: 67, blue: 252, alpha: 255)
            ]
        case .level4:
            ret = [
                UIColor(red: 15, green: 126, blue: 247, alpha: 255),
                UIColor(red: 14, green: 121, blue: 237, alpha: 255)
            ]
        case .level5:
            ret = [
                UIColor(red: 25, green: 93, blue: 234, alpha: 255),
                UIColor(red: 29, green: 99, blue: 233, alpha: 255)
            ]
        case .level6:
            ret = [
                UIColor(red: 67, green: 192, blue: 247, alpha: 255),
                UIColor(red: 66, green: 192, blue: 246, alpha: 255)
            ]
        case .level7:
            ret = [
                UIColor(red: 253, green: 190, blue: 58, alpha: 255),
                UIColor(red: 248, green: 187, blue: 57, alpha: 255)
            ]
        case .level8:
            ret = [
                UIColor(red: 248, green: 62, blue: 42, alpha: 255),
                UIColor(red: 245, green: 70, blue: 47, alpha: 255)
            ]
        case .level9:
            ret = [
                UIColor(red: 245, green: 46, blue: 35, alpha: 255),
                UIColor(red: 236, green: 45, blue: 37, alpha: 255)
            ]
        }

        return ret
    }
}

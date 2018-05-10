//
//  LanguageType.swift
//  Weather
//
//  Created by iMac on 2018/5/10.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

enum LanguageType: String {

    case chinese = "zh"
    case traditionalChinese  = "hk"
    case english = "en"
    case german = "de"
    case spanish = "es"
    case french = "fr"
    case italian = "it"
    case japanese = "jp"
    case koream = "kr"
    case russian = "ru"
    case hindi = "in"
    case thai = "th"

    init(rawValue: String) {

        var value = rawValue
        if rawValue == "zh-cn" || rawValue == "cn" {
            value = "zh"
        } else if rawValue == "zh-hk" {
            value = "hk"
        }
        self.init(rawValue: value)
    }
}

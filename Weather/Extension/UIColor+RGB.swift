//
//  UIColor+RGB.swift
//  Weather
//
//  Created by iMac on 2018/5/8.
//  Copyright © 2018年 iMac. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: CGFloat, alpha: Int) {
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: CGFloat(alpha) / 255.0)
    }
}

//
//  UILabel+Create.swift
//  Weather
//
//  Created by iMac on 2018/5/10.
//  Copyright © 2018年 iMac. All rights reserved.
//

import UIKit

extension UILabel {

    convenience init(textAlignment: NSTextAlignment, textColor: UIColor, textFont: UIFont?) {

        self.init(frame: .zero)

        self.textAlignment = textAlignment
        self.textColor = textColor
        self.font = textFont
    }
}

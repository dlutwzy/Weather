//
//  Config.swift
//  Weather
//
//  Created by iMac on 2018/5/7.
//  Copyright © 2018年 iMac. All rights reserved.
//

import UIKit

class Config {
    static let secretKey: String = "8a77c0aa95ed67b8a17b741f0bfa4136"
    static let commonLeftOffset: CGFloat = 15.0
    static let commonRightOffset: CGFloat = -15.0
    static let commonTopOffset: CGFloat = 15.0
    static let commonBottomOffset: CGFloat = -15.0
    private static var heFengApiKey: String?
    static var apiKey: String {
        get {
            if heFengApiKey == nil {
                
                do {
                    guard let url = R.file.api_KEY() else {
                        return ""
                    }
                    heFengApiKey = try String(contentsOf: url)
                } catch {
                    
                }
            }
            
            return heFengApiKey ?? ""
        }
    }
}

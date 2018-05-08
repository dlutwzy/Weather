//
//  Basic.swift
//  Weather
//
//  Created by WZY on 2018/5/8.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

struct LocationAttribute: Codable {
    
    let cid: String?
    let location: String?
    let cnty: String?
    let lat: String?
    let lon: String?
    let tz: String?
    
    private enum CodingKeys: String, CodingKey {
        case cid
        case location
        case cnty
        case lat
        case lon
        case tz
    }
}

extension LocationAttribute {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LocationAttribute.CodingKeys.self)
        
        cid = try container.decode(String.self, forKey: .cid)
        location = try container.decode(String.self, forKey: .location)
        cnty = try container.decode(String.self, forKey: .cnty)
        lat = try container.decode(String.self, forKey: .lat)
        lon = try container.decode(String.self, forKey: .lon)
        tz = try container.decode(String.self, forKey: .tz)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: LocationAttribute.CodingKeys.self)
        
        try container.encode(cid, forKey: .cid)
        try container.encode(location, forKey: .location)
        try container.encode(cnty, forKey: .cnty)
        try container.encode(lat, forKey: .lat)
        try container.encode(lon, forKey: .lon)
        try container.encode(tz, forKey: .tz)
    }
}

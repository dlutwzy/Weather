//
//  Condition.swift
//  Weather
//
//  Created by WZY on 2018/5/8.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

//struct Basic: Codable {
//    ///
//    let cid: String?
//    ///
//    let location: String?
//    ///
//    let cnty: String?
//    ///
//    let lat: String?
//    ///
//    let lon: String?
//    ///
//    let tz: String?
//    
//    private enum CodingKeys: String, CodingKey {
//        case cid
//        case location
//        case cnty
//        case lat
//        case lon
//        case tz
//    }
//}
//
//extension Basic {
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Basic.CodingKeys.self)
//        
//        cid = try container.decode(String.self, forKey: .cid)
//        location = try container.decode(String.self, forKey: .location)
//        cnty = try container.decode(String.self, forKey: .cnty)
//        lat = try container.decode(String.self, forKey: .lat)
//        lon = try container.decode(String.self, forKey: .lon)
//        tz = try container.decode(String.self, forKey: .tz)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: Basic.CodingKeys.self)
//        
//        try container.encode(cid, forKey: .cid)
//        try container.encode(location, forKey: .location)
//        try container.encode(cnty, forKey: .cnty)
//        try container.encode(lat, forKey: .lat)
//        try container.encode(lon, forKey: .lon)
//        try container.encode(tz, forKey: .tz)
//    }
//}
//
//struct Update: Codable {
//    ///
//    let loc: String?
//    ///
//    let utc: String?
//    
//    private enum CodingKeys: String, CodingKey {
//        case loc
//        case utc
//    }
//}
//
//extension Update {
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Update.CodingKeys.self)
//        
//        loc = try container.decode(String.self, forKey: .loc)
//        utc = try container.decode(String.self, forKey: .utc)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: Update.CodingKeys.self)
//        
//        try container.encode(loc, forKey: .loc)
//        try container.encode(utc, forKey: .utc)
//    }
//}
//
//struct Now: Codable {
//    ///
//    let cloud: String?
//    ///
//    let condCode: String?
//    ///
//    let condTxt: String?
//    ///
//    let fl: String?
//    ///
//    let hum: String?
//    ///
//    let pcpn: String?
//    ///
//    let pres: String?
//    ///
//    let tmp: String?
//    ///
//    let vis: String?
//    ///
//    let windDeg: String?
//    ///
//    let windDir: String?
//    ///
//    let windSc: String?
//    ///
//    let windSpd: String?
//    
//    private enum CodingKeys: String, CodingKey {
//        case cloud
//        case condCode = "cond_code"
//        case condTxt = "cond_txt"
//        case fl
//        case hum
//        case pcpn
//        case pres
//        case tmp
//        case vis
//        case windDeg = "wind_deg"
//        case windDir = "wind_dir"
//        case windSc = "wind_sc"
//        case windSpd = "wind_spd"
//    }
//}
//
//extension Now {
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Now.CodingKeys.self)
//        
//        cloud = try container.decode(String.self, forKey: .cloud)
//        condCode = try container.decode(String.self, forKey: .condCode)
//        condTxt = try container.decode(String.self, forKey: .condTxt)
//        fl = try container.decode(String.self, forKey: .fl)
//        hum = try container.decode(String.self, forKey: .hum)
//        pcpn = try container.decode(String.self, forKey: .pcpn)
//        pres = try container.decode(String.self, forKey: .pres)
//        tmp = try container.decode(String.self, forKey: .tmp)
//        vis = try container.decode(String.self, forKey: .vis)
//        windDeg = try container.decode(String.self, forKey: .windDeg)
//        windDir = try container.decode(String.self, forKey: .windDir)
//        windSc = try container.decode(String.self, forKey: .windSc)
//        windSpd = try container.decode(String.self, forKey: .windSpd)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: Now.CodingKeys.self)
//        
//        try container.encode(cloud, forKey: .cloud)
//        try container.encode(condCode, forKey: .condCode)
//        try container.encode(condTxt, forKey: .condTxt)
//        try container.encode(fl, forKey: .fl)
//        try container.encode(hum, forKey: .hum)
//        try container.encode(pcpn, forKey: .pcpn)
//        try container.encode(pres, forKey: .pres)
//        try container.encode(tmp, forKey: .tmp)
//        try container.encode(vis, forKey: .vis)
//        try container.encode(windDeg, forKey: .windDeg)
//        try container.encode(windDir, forKey: .windDir)
//        try container.encode(windSc, forKey: .windSc)
//        try container.encode(windSpd, forKey: .windSpd)
//    }
//}
//
//struct HeWeather6Item: Codable {
//    ///
//    let basic: Basic?
//    ///
//    let update: Update?
//    ///
//    let status: String?
//    ///
//    let now: Now?
//    
//    private enum CodingKeys: String, CodingKey {
//        case basic
//        case update
//        case status
//        case now
//    }
//}
//
//extension HeWeather6Item {
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: HeWeather6Item.CodingKeys.self)
//        
//        basic = try container.decode(Basic.self, forKey: .basic)
//        update = try container.decode(Update.self, forKey: .update)
//        status = try container.decode(String.self, forKey: .status)
//        now = try container.decode(Now.self, forKey: .now)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: HeWeather6Item.CodingKeys.self)
//        
//        try container.encode(basic, forKey: .basic)
//        try container.encode(update, forKey: .update)
//        try container.encode(status, forKey: .status)
//        try container.encode(now, forKey: .now)
//    }
//}
//
//struct Root: Codable {
//    ///
//    let HeWeather6: [HeWeather6Item]?
//    
//    private enum CodingKeys: String, CodingKey {
//        case HeWeather6
//    }
//}
//
//extension Root {
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Root.CodingKeys.self)
//        
//        HeWeather6 = try container.decode([HeWeather6Item].self, forKey: .HeWeather6)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: Root.CodingKeys.self)
//        
//        try container.encode(HeWeather6, forKey: .HeWeather6)
//    }
//}


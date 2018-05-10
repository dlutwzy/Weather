//
//  Condition.swift
//  Weather
//
//  Created by WZY on 2018/5/8.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

class Condition: HeWeatherBase {

    let current: CurrentForecast?

    required init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: Condition.CodingKeys.self)
        current = try container.decode(CurrentForecast.self, forKey: .current)

        try super.init(from: decoder)
    }

    override func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: Condition.CodingKeys.self)
        try container.encode(current, forKey: .current)

        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {

        case current = "now"
    }
}

struct CurrentForecast: Codable {

    let cloud: String?
    let condCode: ConditionCode?
    let condTxt: String?
    let fl: String?
    let hum: String?
    let pcpn: String?
    let pres: String?
    let tmp: String?
    let vis: String?
    let windDeg: String?
    let windDir: String?
    let windSc: String?
    let windSpd: String?

    private enum CodingKeys: String, CodingKey {
        case cloud
        case condCode = "cond_code"
        case condTxt = "cond_txt"
        case fl
        case hum
        case pcpn
        case pres
        case tmp
        case vis
        case windDeg = "wind_deg"
        case windDir = "wind_dir"
        case windSc = "wind_sc"
        case windSpd = "wind_spd"
    }
}

extension CurrentForecast {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CurrentForecast.CodingKeys.self)

        cloud = try container.decode(String.self, forKey: .cloud)
        let condCodeStr = try container.decode(String.self, forKey: .condCode)
        condCode = ConditionCode(rawValue: Int(condCodeStr) ?? 999)
        condTxt = try container.decode(String.self, forKey: .condTxt)
        fl = try container.decode(String.self, forKey: .fl)
        hum = try container.decode(String.self, forKey: .hum)
        pcpn = try container.decode(String.self, forKey: .pcpn)
        pres = try container.decode(String.self, forKey: .pres)
        tmp = try container.decode(String.self, forKey: .tmp)
        vis = try container.decode(String.self, forKey: .vis)
        windDeg = try container.decode(String.self, forKey: .windDeg)
        windDir = try container.decode(String.self, forKey: .windDir)
        windSc = try container.decode(String.self, forKey: .windSc)
        windSpd = try container.decode(String.self, forKey: .windSpd)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CurrentForecast.CodingKeys.self)

        try container.encode(cloud, forKey: .cloud)
        try container.encode("\(condCode?.rawValue ?? 999)", forKey: .condCode)
        try container.encode(condTxt, forKey: .condTxt)
        try container.encode(fl, forKey: .fl)
        try container.encode(hum, forKey: .hum)
        try container.encode(pcpn, forKey: .pcpn)
        try container.encode(pres, forKey: .pres)
        try container.encode(tmp, forKey: .tmp)
        try container.encode(vis, forKey: .vis)
        try container.encode(windDeg, forKey: .windDeg)
        try container.encode(windDir, forKey: .windDir)
        try container.encode(windSc, forKey: .windSc)
        try container.encode(windSpd, forKey: .windSpd)
    }
}

struct ConditionRoot: Codable {

    let heWeather: [Condition]?

    private enum CodingKeys: String, CodingKey {
        case heWeather = "HeWeather6"
    }
}

extension ConditionRoot {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ConditionRoot.CodingKeys.self)

        heWeather = try container.decode([Condition].self, forKey: .heWeather)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ConditionRoot.CodingKeys.self)

        try container.encode(heWeather, forKey: .heWeather)
    }
}


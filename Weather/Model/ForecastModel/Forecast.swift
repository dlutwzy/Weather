//
//  Forecast.swift
//  Weather
//
//  Created by iMac on 2018/5/8.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

struct DailyForecast: Codable {

    let condCodeD: String?
    let condCodeN: String?
    let condTxtD: String?
    let condTxtN: String?
    let date: String?
    let hum: String?
    let mr: String?
    let ms: String?
    let pcpn: String?
    let pop: String?
    let pres: String?
    let sr: String?
    let ss: String?
    let tmpMax: String?
    let tmpMin: String?
    let uvIndex: String?
    let vis: String?
    let windDeg: String?
    let windDir: String?
    let windSc: String?
    let windSpd: String?

    private enum CodingKeys: String, CodingKey {
        case condCodeD = "cond_code_d"
        case condCodeN = "cond_code_n"
        case condTxtD = "cond_txt_d"
        case condTxtN = "cond_txt_n"
        case date
        case hum
        case mr
        case ms
        case pcpn
        case pop
        case pres
        case sr
        case ss
        case tmpMax = "tmp_max"
        case tmpMin = "tmp_min"
        case uvIndex = "uv_index"
        case vis
        case windDeg = "wind_deg"
        case windDir = "wind_dir"
        case windSc = "wind_sc"
        case windSpd = "wind_spd"
    }
}
extension DailyForecast {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DailyForecast.CodingKeys.self)

        condCodeD = try container.decode(String.self, forKey: .condCodeD)
        condCodeN = try container.decode(String.self, forKey: .condCodeN)
        condTxtD = try container.decode(String.self, forKey: .condTxtD)
        condTxtN = try container.decode(String.self, forKey: .condTxtN)
        date = try container.decode(String.self, forKey: .date)
        hum = try container.decode(String.self, forKey: .hum)
        mr = try container.decode(String.self, forKey: .mr)
        ms = try container.decode(String.self, forKey: .ms)
        pcpn = try container.decode(String.self, forKey: .pcpn)
        pop = try container.decode(String.self, forKey: .pop)
        pres = try container.decode(String.self, forKey: .pres)
        sr = try container.decode(String.self, forKey: .sr)
        ss = try container.decode(String.self, forKey: .ss)
        tmpMax = try container.decode(String.self, forKey: .tmpMax)
        tmpMin = try container.decode(String.self, forKey: .tmpMin)
        uvIndex = try container.decode(String.self, forKey: .uvIndex)
        vis = try container.decode(String.self, forKey: .vis)
        windDeg = try container.decode(String.self, forKey: .windDeg)
        windDir = try container.decode(String.self, forKey: .windDir)
        windSc = try container.decode(String.self, forKey: .windSc)
        windSpd = try container.decode(String.self, forKey: .windSpd)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DailyForecast.CodingKeys.self)

        try container.encode(condCodeD, forKey: .condCodeD)
        try container.encode(condCodeN, forKey: .condCodeN)
        try container.encode(condTxtD, forKey: .condTxtD)
        try container.encode(condTxtN, forKey: .condTxtN)
        try container.encode(date, forKey: .date)
        try container.encode(hum, forKey: .hum)
        try container.encode(mr, forKey: .mr)
        try container.encode(ms, forKey: .ms)
        try container.encode(pcpn, forKey: .pcpn)
        try container.encode(pop, forKey: .pop)
        try container.encode(pres, forKey: .pres)
        try container.encode(sr, forKey: .sr)
        try container.encode(ss, forKey: .ss)
        try container.encode(tmpMax, forKey: .tmpMax)
        try container.encode(tmpMin, forKey: .tmpMin)
        try container.encode(uvIndex, forKey: .uvIndex)
        try container.encode(vis, forKey: .vis)
        try container.encode(windDeg, forKey: .windDeg)
        try container.encode(windDir, forKey: .windDir)
        try container.encode(windSc, forKey: .windSc)
        try container.encode(windSpd, forKey: .windSpd)
    }
}

class HeWeatherBase: Codable {
    
    var basic: LocationAttribute?
    var update: UpdateTimestamp?
    var status: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HeWeatherBase.CodingKeys.self)
        
        basic = try container.decode(LocationAttribute.self, forKey: .basic)
        update = try container.decode(UpdateTimestamp.self, forKey: .update)
        status = try container.decode(String.self, forKey: .status)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: HeWeatherBase.CodingKeys.self)
        
        try container.encode(basic, forKey: .basic)
        try container.encode(update, forKey: .update)
        try container.encode(status, forKey: .status)
    }
    
    private enum CodingKeys: String, CodingKey {
        case basic
        case update
        case status
    }
}

class HeWeather: HeWeatherBase {
    
    var dailyForecast: [DailyForecast]?
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: HeWeather.CodingKeys.self)
        dailyForecast = try container.decode([DailyForecast].self, forKey: .dailyForecast)
        
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: HeWeather.CodingKeys.self)
        try container.encode(dailyForecast, forKey: .dailyForecast)
        
        try super.encode(to: encoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case dailyForecast = "daily_forecast"
    }
}

//struct HeWeather: Codable {
//
//    let basic: LocationAttribute?
//    let update: UpdateTimestamp?
//    let status: String?
//    let dailyForecast: [DailyForecast]?
//
//    private enum CodingKeys: String, CodingKey {
//        case basic
//        case update
//        case status
//        case dailyForecast = "daily_forecast"
//    }
//}
//extension HeWeather {
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: HeWeather.CodingKeys.self)
//
//        basic = try container.decode(LocationAttribute.self, forKey: .basic)
//        update = try container.decode(UpdateTimestamp.self, forKey: .update)
//        status = try container.decode(String.self, forKey: .status)
//        dailyForecast = try container.decode([DailyForecast].self, forKey: .dailyForecast)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: HeWeather.CodingKeys.self)
//
//        try container.encode(basic, forKey: .basic)
//        try container.encode(update, forKey: .update)
//        try container.encode(status, forKey: .status)
//        try container.encode(dailyForecast, forKey: .dailyForecast)
//    }
//}

struct Forecast: Codable {

    let heWeather: [HeWeather]?

    private enum CodingKeys: String, CodingKey {
        case heWeather = "HeWeather6"
    }
}

extension Forecast {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Forecast.CodingKeys.self)

        heWeather = try container.decode([HeWeather].self, forKey: .heWeather)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Forecast.CodingKeys.self)

        try container.encode(heWeather, forKey: .heWeather)
    }
}

//
//  HeWeatherBase.swift
//  Weather
//
//  Created by iMac on 2018/5/9.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

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

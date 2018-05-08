//
//  ForecastRouter.swift
//  Weather
//
//  Created by iMac on 2018/5/8.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

protocol ForecastRouterReuqest {
    func request() -> DataRequest
}

func AlamofireRequest(url: URLRequestConvertible)-> DataRequest {
    return Alamofire.request(url)
}

enum ForecastRouter: URLRequestConvertible, ForecastRouterReuqest {

    case forecast(location: CLLocation)
    case now(location: CLLocation)

    private struct StaticValue {
        static let baseURLString = "https://free-api.heweather.com/s6/weather"
        static let lang = "en"
        static let unit = "m"
    }

    func asURLRequest() throws -> URLRequest {
        let result: (path: String, parameters: Parameters) = {
            switch self {
            case .forecast(let location):
                return ("/forecast",
                        ["location": "\(location.coordinate.latitude),\(location.coordinate.longitude)"]
                )
            case .now(let location):
                return ("/now",
                        ["location": "\(location.coordinate.latitude),\(location.coordinate.longitude)"]
                )
            }
        }()

        let url = try  StaticValue.baseURLString.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))

        var parameters = result.parameters
        parameters["key"] = Config.apiKey
        parameters["lang"] = StaticValue.lang
        parameters["unit"] = StaticValue.unit

        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }

    func request() -> DataRequest {
        return AlamofireRequest(url: self)
    }
}

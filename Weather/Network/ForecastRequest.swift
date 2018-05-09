//
//  ForecastRequest.swift
//  Weather
//
//  Created by iMac on 2018/5/8.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

class ForecastRequest {
    static func getForecast(location: CLLocation,
                            responseBlcok: @escaping (Forecast?) -> Void) {
        ForecastRouter.forecast(location: location)
            .request()
            .responseJModel(queue: DispatchQueue.global(qos: .background)) { (response: DataResponse<ForecastRoot>) in
                guard let heWeatherList = response.result.value?.heWeather else {
                    responseBlcok(nil)
                    return
                }
                if heWeatherList.count != 1 {
                    responseBlcok(nil)
                    return
                }
                responseBlcok(heWeatherList[0])
        }
    }

    static func getCurrentCondition(location: CLLocation,
                                    responseBlcok: @escaping (Condition?) -> Void) {
        ForecastRouter.now(location: location)
            .request()
            .responseJModel(queue: DispatchQueue.global(qos: .background)) { (response: DataResponse<ConditionRoot>) in
                guard let heWeatherList = response.result.value?.heWeather else {
                    responseBlcok(nil)
                    return
                }
                if heWeatherList.count != 1 {
                    responseBlcok(nil)
                    return
                }
                responseBlcok(heWeatherList[0])
        }
    }
}

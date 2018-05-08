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
            .responseJModel(queue: DispatchQueue.global(qos: .background)) { (response: DataResponse<Forecast>) in
                responseBlcok(response.result.value)
        }
    }

//    static func getRankingBookDetail(rankingId: String, responseBlock: @escaping (RankingBookDetail?) -> Void) {
//        BingeBookRouter.rankingDetail(rankingId: rankingId).request().responseString { (res) in
//
//        }
//    }
}

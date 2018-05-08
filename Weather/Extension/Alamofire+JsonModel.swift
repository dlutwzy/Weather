//
//  Alamofire+JsonModel.swift
//  Weather
//
//  Created by iMac on 2018/5/8.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    /// Creates a response serializer that returns a result string type initialized from the response data with
    /// the specified string encoding.
    ///
    /// - parameter encoding: The string encoding. If `nil`, the string encoding will be determined from the server
    ///                       response, falling back to the default HTTP default character set, ISO-8859-1.
    ///
    /// - returns: A string response serializer.
    public static func jModelResponseSerializer<T:Codable>(type: T.Type) -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return Result.failure(error!) }

            guard let validData = data else {
                return .failure(AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: NSError(domain: "no data", code: 1, userInfo: nil))))
            }

            let decoder = JSONDecoder()
            if let ranking = try? decoder.decode(T.self, from: validData) {
                return .success(ranking)
            } else {
                return .failure(AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: NSError(domain: "decode failed", code: 1, userInfo: nil))))
            }
        }
    }

    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter encoding:          The string encoding. If `nil`, the string encoding will be determined from the
    ///                                server response, falling back to the default HTTP default character set,
    ///                                ISO-8859-1.
    /// - parameter completionHandler: A closure to be executed once the request has finished.
    ///
    /// - returns: The request.
    @discardableResult
    public func responseJModel<T:Codable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: DataRequest.jModelResponseSerializer(type: T.self),
            completionHandler: completionHandler
        )
    }
}

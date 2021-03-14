//
//  APIError.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/14.
//

import Foundation

enum APIError: Error, LocalizedError {
    case unknown
    case networkError(error: Error)
    case httpError(httpCode: Int)
    case invalidResponseData
    case decodingError
    case encodeingError

    var errorDescription: String? {

        switch self {

        case .unknown:
            return "unknown error occured"

        case .networkError(let error):
            return "network error occured: \(error)"

        case .httpError(let httpCode):
            return "HTTP error occured: \(httpCode)"

        case .invalidResponseData:
            return "invalidResponseData error occured"

        case .decodingError:
            return "decodingError error occured"

        case .encodeingError:
            return "encodingError error occured"
        }

    }
}

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

    enum ErrorCode: Int {
        case badRequest = 400
        case unAuthorized = 401
        case forBidden = 403
        case notFound = 404
        case serverError = 500
    }

    var errorDescription: String? {

        switch self {

        case .unknown:
            return "unknown error occured"

        case .networkError:
            return "network error occured"

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

    func httpCodeErrorMessage(httpCode: Int) -> String {

        switch ErrorCode(rawValue: httpCode) {

        case .badRequest:
            return "BadRequest\n\(Resources.Strings.Error.checkYourInput)"

        case .unAuthorized:
            return "UnAuthorized\n\(Resources.Strings.Error.checkYourInput)"

        case .forBidden:
            return "Forbidden\n\(Resources.Strings.Error.forbiddenError)"

        case .notFound:
            return "NotFound\n\(Resources.Strings.Error.notFoundError)"

        case .serverError:
            return "ServerError\n\(Resources.Strings.Error.serverError)"

        case .none:
            return "UnkownError\n\(Resources.Strings.Error.unknownError)"
        }
    }
}

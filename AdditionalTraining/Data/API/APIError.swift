//
//  APIError.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/14.
//

import Foundation

enum APIError: Error {
    case request
    case network(error: Error)
    case emptyResponse
    case decode
    case http(status: Int)

    func desciption() -> String {

        switch self {

        case .request:
            return "リクエストエラー"

        case .network(let error):
            return "ネットワークエラー: \(error)"

        case .emptyResponse:
            return "レスポンスエラー"

        case .decode
            return "デコードエラー"

        case .http(let status):
            return "ステータスエラー: \(status)"
        }
    }
}

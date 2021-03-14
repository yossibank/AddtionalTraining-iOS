//
//  HttpMethod.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/14.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"

    func urlRequest(
        url: URL,
        data: Data?
    ) throws -> URLRequest? {

        var request = URLRequest(url: url)

        switch self {

        case .get:
            guard
                let data = data
            else {
                request.httpMethod = rawValue
                return request
            }

            guard
                var components = URLComponents(
                    url: url,
                    resolvingAgainstBaseURL: true
                ),
                let dictionary = try JSONSerialization.jsonObject(
                    with: data,
                    options: []
                ) as? [String: Any]
            else {
                return nil
            }

            components.queryItems = dictionary.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }

            guard
                let getUrl = components.url
            else {
                return nil
            }

            var request = URLRequest(url: getUrl)
            request.httpMethod = rawValue
            return request

        case .post, .patch, .put, .delete:
            request.httpMethod = rawValue
            request.httpBody = data
            return request
        }
    }
}

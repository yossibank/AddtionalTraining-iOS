//
//  BaseRequest.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/14.
//

import Foundation
import Combine

protocol BaseRequest {

    associatedtype Request: Encodable
    associatedtype Response: Decodable

    var baseUrl: String { get }
    var path: String { get }
    var url: URL? { get }
    var method: HttpMethod { get }
    var headerFields: [String: String] { get }
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }

    func request(_ parameter: Request) -> Future<Response, APIError>
}

extension BaseRequest {

    var baseUrl: String {
        Resources.Strings.API.baseUrl
    }

    var url: URL? {
        URL(string: baseUrl + path)
    }

    var headerFields: [String: String] {
        [String: String]()
    }

    var defaultHeaderFields: [String: String] {
        ["content-type": "application/json"]
    }

    var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    func request(_ parameter: Request) -> Future<Response, APIError> {
        do {
            let data = try encoder.encode(parameter)
            return request(data)
        } catch {
            return .init() { promise in
                promise(.failure(.encodeingError))
            }
        }
    }

    private func request(_ data: Data?) -> Future<Response, APIError> {
        return .init { promise in
            do {
                guard
                    let url = url,
                    var urlRequest = try method.urlRequest(url: url, data: data)
                else {
                    return
                }

                urlRequest.allHTTPHeaderFields = defaultHeaderFields.merging(headerFields) { $1 }
                urlRequest.timeoutInterval = 5

                URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    if let error = error {
                        promise(.failure(.networkError(error: error)))
                        return
                    }

                    guard
                        let data = data,
                        let response = response as? HTTPURLResponse
                    else {
                        promise(.failure(.invalidResponseData))
                        return
                    }

                    guard 200..<300 ~= response.statusCode else {
                        promise(.failure(.httpError(httpCode: response.statusCode)))
                        return
                    }

                    do {
                        let entity = try decoder.decode(Response.self, from: data)
                        promise(.success(entity))
                    } catch {
                        promise(.failure(.decodingError))
                    }
                }.resume()

            } catch {
                promise(.failure(.unknown))
                return
            }
        }
    }
}

//
//  LoginRequest.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/14.
//

struct LoginRequest: BaseRequest {

    typealias Response = LoginResponse

    struct Request: Encodable {
        var email: String
        var password: String
    }

    var path: String { "/login" }
    var method: HttpMethod { .post }
}

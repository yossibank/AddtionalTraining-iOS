//
//  SignupRequest.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/14.
//

struct SignupRequest: BaseRequest {

    typealias Response = SignupResponse

    struct Request: Encodable {
        var email: String
        var password: String
    }

    var path: String { "/sign_up" }
    var method: HttpMethod { .post }
}

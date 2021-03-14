//
//  LoginResponse.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/14.
//

struct LoginResponse: Decodable {
    var status: Int
    var result: User

    struct User: Decodable {
        var id: Int
        var email: String
        var token: String
    }
}

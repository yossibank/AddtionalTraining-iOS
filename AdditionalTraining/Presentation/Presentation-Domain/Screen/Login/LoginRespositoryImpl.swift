//
//  LoginRespositoryImpl.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/15.
//

import Combine

final class LoginRepositoryImpl: LoginRepository {

    func login(email: String, password: String) -> AnyPublisher<LoginResponse, APIError> {
        LoginRequest()
            .request(.init(email: email, password: password))
            .eraseToAnyPublisher()
    }
}

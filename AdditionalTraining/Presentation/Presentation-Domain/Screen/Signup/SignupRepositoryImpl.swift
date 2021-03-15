//
//  SignupRepositoryImpl.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/15.
//

import Combine

final class SignupRepositoryImpl: SignupRepository {

    func signup(email: String, password: String) -> AnyPublisher<SignupResponse, APIError> {
        SignupRequest()
            .request(.init(email: email, password: password))
            .eraseToAnyPublisher()
    }
}

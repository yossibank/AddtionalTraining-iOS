//
//  SignupRepository.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/15.
//

import Combine

protocol SignupRepository: AnyObject {
    func signup(email: String, password: String) -> AnyPublisher<SignupResponse, APIError>
}

//
//  LoginRepository.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/15.
//

import Combine

protocol LoginRepository: AnyObject {
    func login(email: String, password: String) -> AnyPublisher<LoginResponse, APIError>
}

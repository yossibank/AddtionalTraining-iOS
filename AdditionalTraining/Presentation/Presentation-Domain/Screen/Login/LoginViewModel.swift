//
//  LoginViewModel.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/14.
//

import Combine

final class LoginViewModel {

    @Published var email: String = .blank
    @Published var password: String = .blank

    var validationEmailText: String? {
        EmailValidator.validate(email).errorDescription
    }

    var validationPasswordText: String? {
        PasswordValidator.validate(password).errorDescription
    }

    private var cancellables: Set<AnyCancellable> = .init()

    func isValidate() -> Bool {
        let results = [
            EmailValidator.validate(email).isValid,
            PasswordValidator.validate(password).isValid
        ]
        return results.allSatisfy { $0 }
    }

    func login() {
        LoginRequest()
            .request(.init(email: email, password: password))
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    print("OK")
                case .failure(let error):
                    print("ERROR: \(error.desciption())")
                }
            }, receiveValue: { response in
                print(response.result)
            })
            .store(in: &cancellables)
    }
}

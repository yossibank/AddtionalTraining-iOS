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
    @Published private(set) var newWorkState: NetworkState = .standby

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

    func shouldEnabledButton() -> Bool {
        !(email.isEmpty || password.isEmpty)
            && validationEmailText == nil
            && validationPasswordText == nil
    }

    func login() {
        newWorkState = .loading

        LoginRequest()
            .request(.init(email: email, password: password))
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self else { return }

                switch result {

                case .finished:
                    self.newWorkState = .finished

                case .failure(let error):
                    self.newWorkState = .error(error)

                }
            }, receiveValue: { response in
                print(response.result)
            })
            .store(in: &cancellables)
    }
}

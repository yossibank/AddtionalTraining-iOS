//
//  SignupViewModel.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/14.
//

import Combine

final class SignupViewModel {

    @Published var email: String = .blank
    @Published var password: String = .blank
    @Published var confirmPassword: String = .blank
    @Published var networkState: NetworkState = .standby

    var validationEmailText: String? {
        EmailValidator.validate(email).errorDescription
    }

    var validationPasswordText: String? {
        PasswordValidator.validate(password).errorDescription
    }

    var validationConfirmPasswordText: String? {
        ConfirmPasswordValidator.validate(password, confirmPassword).errorDescription
    }

    private var cancellables: Set<AnyCancellable> = .init()

    func isValidate() -> Bool {
        let results = [
            EmailValidator.validate(email).isValid,
            PasswordValidator.validate(password).isValid,
            ConfirmPasswordValidator.validate(password, confirmPassword).isValid
        ]
        return results.allSatisfy { $0 }
    }

    func shouldEnabledButton() -> Bool {
        !(email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
            && validationEmailText == nil
            && validationPasswordText == nil
            && validationConfirmPasswordText == nil
    }

    func signup() {
        networkState = .loading

        SignupRequest()
            .request(.init(email: email, password: password))
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self else { return }

                switch result {

                case .finished:
                    self.networkState = .finished

                case .failure(let error):
                    self.networkState = .error(error)

                }
            }, receiveValue: { response in
                KeychainManager.shared.setToken(response.result.token)
            })
            .store(in: &cancellables)
    }
}

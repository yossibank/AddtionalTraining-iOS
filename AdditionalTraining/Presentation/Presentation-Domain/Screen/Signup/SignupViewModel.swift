//
//  SignupViewModel.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/14.
//

import Foundation
import Combine

final class SignupViewModel {

    @Published var email: String = .blank
    @Published var password: String = .blank
    @Published var confirmPassword: String = .blank
    @Published private(set) var networkState: NetworkState = .standby

    var validationEmailText: String? {
        EmailValidator.validate(email).errorDescription
    }

    var validationPasswordText: String? {
        PasswordValidator.validate(password).errorDescription
    }

    var validationConfirmPasswordText: String? {
        ConfirmPasswordValidator.validate(password, confirmPassword).errorDescription
    }

    private let repository: SignupRepository

    private var cancellables: Set<AnyCancellable> = .init()

    private(set) lazy var isEnabledButton = Publishers
        .CombineLatest3($email, $password, $confirmPassword)
        .receive(on: RunLoop.main)
        .map { _ in self.shouldEnabledButton() }
        .eraseToAnyPublisher()

    init(repository: SignupRepository) {
        self.repository = repository
    }

    func signup() {
        networkState = .loading

        repository
            .signup(email: email, password: password)
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

    func isValidate() -> Bool {
        let results = [
            EmailValidator.validate(email).isValid,
            PasswordValidator.validate(password).isValid,
            ConfirmPasswordValidator.validate(password, confirmPassword).isValid
        ]
        return results.allSatisfy { $0 }
    }

    private func shouldEnabledButton() -> Bool {
        !(email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
            && validationEmailText == nil
            && validationPasswordText == nil
            && validationConfirmPasswordText == nil
    }
}

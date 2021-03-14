//
//  ConfirmPasswordValidator.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/14.
//

import Foundation

enum ConfirmPasswordValidator: ValidatorProtocol {

    typealias ValueType = String?
    typealias ErrorType = ConfirmPasswordError

    static func validate(
        _ password: String,
        _ confirmPassword: String
    ) -> ValidationResult<ConfirmPasswordError> {
        if password != confirmPassword {
            return .invalid(.notMatch)
        }

        return .valid
    }

    static func validate(_ value: String?) -> ValidationResult<ConfirmPasswordError> {
        guard
            let value = value,
            !value.isEmpty
        else {
            return .invalid(.empty)
        }

        if value.count < 6 {
            return .invalid(.tooShort)
        }

        return .valid
    }
}

enum ConfirmPasswordError: LocalizedError {
    case empty
    case tooShort
    case notMatch

    var errorDescription: String? {

        switch self {

        case .empty:
            return Resources.Strings.Validation.emptyPassword

        case .tooShort:
            return Resources.Strings.Validation.invalidLengthPassword

        case .notMatch:
            return Resources.Strings.Validation.notMatchingPassword
        }
    }
}

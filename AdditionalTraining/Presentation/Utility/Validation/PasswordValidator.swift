//
//  PasswordValidator.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/14.
//

import Foundation

enum PasswordValidator: ValidatorProtocol {

    typealias ValueType = String?
    typealias ErrorType = PasswordError

    static func validate(_ value: String?) -> ValidationResult<PasswordError> {
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

enum PasswordError: LocalizedError {
    case empty
    case tooShort

    var errorDescription: String? {

        switch self {

        case .empty:
            return Resources.Strings.Validation.emptyPassword

        case .tooShort:
            return Resources.Strings.Validation.invalidLengthPassword
        }
    }
}

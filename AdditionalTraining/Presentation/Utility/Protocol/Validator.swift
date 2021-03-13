//
//  Validator.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/13.
//

import Foundation

protocol ValidatorProtocol {
    associatedtype ValueType
    associatedtype ErrorType: Error
    static func validate(_ value: ValueType) -> ValidationResult<ErrorType>
}

enum ValidationResult<E: Error> {
    case valid
    case invalid(E)

    var isValid: Bool {
        if case .valid = self {
            return true
        }
        return false
    }

    var errorDescription: String? {
        if case .invalid(let error) = self {
            return error.localizedDescription
        }
        return nil
    }
}

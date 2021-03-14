//
//  AppStrings.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/13.
//

struct StringResources {

    private typealias Internal = R.string

    struct App {
        static var emailAddress: String { Internal.localizable.email_address() }
        static var password: String { Internal.localizable.password() }
        static var confirmPassword: String { Internal.localizable.confirm_password() }
    }

    struct Naviagtion {
        static var signup: String { Internal.localizable.signup() }
        static var login: String { Internal.localizable.login() }
    }

    struct Alert {
        static var close: String { Internal.localizable.close() }
        static var okay: String { Internal.localizable.ok() }
        static var error: String { Internal.localizable.error() }
    }

    struct Error {
        static var unknownError: String { Internal.localizable.unknown_error() }
        static var forbiddenError: String { Internal.localizable.forbidden_error() }
        static var notFoundError: String { Internal.localizable.not_found_url_error() }
        static var serverError: String { Internal.localizable.server_error() }
        static var checkYourInput: String { Internal.localizable.please_check_your_input() }
    }

    struct Validation {
        private static let minimumLength = "6"

        static var emptyEmailAddress: String { Internal.localizable.not_filled(Resources.Strings.App.emailAddress) }
        static var emptyPassword: String { Internal.localizable.not_filled(Resources.Strings.App.password) }
        static var emptyConfirmPassword: String { Internal.localizable.not_filled(Resources.Strings.App.confirmPassword) }
        static var invalidEmailFormat: String { Internal.localizable.not_correct_email_format() }
        static var invalidLengthPassword: String { Internal.localizable.not_length_password(minimumLength) }
        static var notMatchingPassword: String { Internal.localizable.not_matching_password() }
    }

    struct API {
        static var baseUrl: String { "http://54.250.239.8" }
    }
}

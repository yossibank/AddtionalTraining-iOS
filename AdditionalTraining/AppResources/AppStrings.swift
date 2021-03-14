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
    }

    struct Naviagtion {
        static var signup: String { Internal.localizable.signup() }
        static var login: String { Internal.localizable.login() }
    }

    struct Validation {
        private static let minimumLength = "6"

        static var emptyEmailAddress: String { Internal.localizable.not_filled(Resources.Strings.App.emailAddress) }
        static var emptyPassword: String { Internal.localizable.not_filled(Resources.Strings.App.password) }
        static var invalidEmailFormat: String { Internal.localizable.not_correct_email_format() }
        static var invalidLengthPassword: String { Internal.localizable.not_length_password(minimumLength) }
        static var notMatchingPassword: String { Internal.localizable.not_matching_password() }
    }
}

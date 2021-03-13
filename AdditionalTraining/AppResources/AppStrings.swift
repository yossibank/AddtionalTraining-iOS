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
    }

    struct Naviagtion {
        static var signup: String { Internal.localizable.signup() }
        static var login: String { Internal.localizable.login() }
    }

    struct Validation {
        static var emptyEmailAddress: String { Internal.localizable.not_filled(Resources.Strings.App.emailAddress) }
        static var invalidEmailFormat: String { Internal.localizable.not_correct_email_format() }
    }
}

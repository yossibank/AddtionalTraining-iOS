//
//  AppStrings.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/13.
//

struct StringResources {

    private typealias Internal = R.string

    struct Naviagtion {
        static var signup: String { Internal.localizable.signup() }
        static var login: String { Internal.localizable.login() }
    }
}

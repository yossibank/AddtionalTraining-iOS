//
//  LoginViewController.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/13.
//

import UIKit

final class LoginViewController: UIViewController {

    private let router: RouterProtocol = Router()

    static func createInstance() -> LoginViewController {
        let instance = LoginViewController.instantiateInitialViewController()
        return instance
    }

    @IBAction private func showSignupScreen(_ sender: Any) {
        router.present(.signup, from: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension LoginViewController: NavigationBarConfiguration {

    var navigationTitle: String? {
        Resources.Strings.Naviagtion.login
    }
}

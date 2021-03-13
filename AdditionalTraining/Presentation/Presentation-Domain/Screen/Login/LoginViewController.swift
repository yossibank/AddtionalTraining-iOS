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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

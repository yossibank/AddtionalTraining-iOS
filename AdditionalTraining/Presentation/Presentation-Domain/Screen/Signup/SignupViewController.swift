//
//  SignupViewController.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/13.
//

import UIKit

final class SignupViewController: UIViewController {

    private let router: RouterProtocol = Router()

    static func createInstance() -> SignupViewController {
        let instance = SignupViewController.instantiateInitialViewController()
        return instance
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

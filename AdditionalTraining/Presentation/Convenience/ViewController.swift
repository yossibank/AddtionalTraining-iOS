//
//  ViewController.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/13.
//

extension Resources {

    static var ViewControllers: ViewController {
        ViewController()
    }

    struct ViewController {

        var App: AppControllers {
            AppControllers()
        }

        struct AppControllers {

            func signup() -> SignupViewController {
                let vc = SignupViewController.createInstance()
                return vc
            }

            func login() -> LoginViewController {
                let viewModel = LoginViewModel()
                let vc = LoginViewController.createInstance(viewModel: viewModel)
                return vc
            }
        }
    }
}

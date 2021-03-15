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
                let repository = SignupRepositoryImpl()
                let viewModel = SignupViewModel(repository: repository)
                let vc = SignupViewController.createInstance(viewModel: viewModel)
                return vc
            }

            func login() -> LoginViewController {
                let repository = LoginRepositoryImpl()
                let viewModel = LoginViewModel(repository: repository)
                let vc = LoginViewController.createInstance(viewModel: viewModel)
                return vc
            }
        }
    }
}

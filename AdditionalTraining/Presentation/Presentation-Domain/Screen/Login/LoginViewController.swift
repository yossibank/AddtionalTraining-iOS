//
//  LoginViewController.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/13.
//

import UIKit
import Combine

final class LoginViewController: UIViewController {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var validateEmailLabel: UILabel!
    @IBOutlet private weak var validatePasswordLabel: UILabel!
    @IBOutlet private weak var loginButton: UIButton!

    var keyboardNotifier: KeyboardNotifier = KeyboardNotifier()

    private let router: RouterProtocol = Router()

    private var viewModel: LoginViewModel!
    private var cancellables: Set<AnyCancellable> = .init()

    static func createInstance(viewModel: LoginViewModel) -> LoginViewController {
        let instance = LoginViewController.instantiateInitialViewController()
        instance.viewModel = viewModel
        return instance
    }

    @IBAction private func showBookListScreen(_ sender: Any) {
        if viewModel.isValidate() {
            viewModel.login()
        }
    }

    @IBAction private func showSignupScreen(_ sender: Any) {
        router.present(.signup, from: self, presentationStyle: .fullScreen)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listenerKeyboard(keyboardNotifier: keyboardNotifier)
        bindValue()
        bindViewModel()
    }
}

extension LoginViewController {

    private func bindValue() {
        emailTextField.textDidChnagePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.email, on: viewModel)
            .store(in: &cancellables)

        passwordTextField.textDidChnagePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellables)
    }

    private func bindViewModel() {
        viewModel.$email
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .dropFirst()
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.validateEmailLabel.text = self.viewModel.validationEmailText
            }
            .store(in: &cancellables)

        viewModel.$password
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .dropFirst()
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.validatePasswordLabel.text = self.viewModel.validationPasswordText
            }
            .store(in: &cancellables)

        Publishers
            .CombineLatest(viewModel.$email, viewModel.$password)
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .map { _ in self.viewModel.shouldEnabledButton() }
            .sink { [weak self] isEnabled in
                guard let self = self else { return }

                self.loginButton.alpha = isEnabled ? 1.0 : 0.5
                self.loginButton.isEnabled = isEnabled
            }
            .store(in: &cancellables)
    }
}

extension LoginViewController {

    override func touchesBegan(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        view.endEditing(true)
    }
}

extension LoginViewController: KeyboardDelegate {

    func keyboardPresent(_ height: CGFloat) {
        let displayHeight = view.frame.height - height
        let bottomOffsetY = stackView.convert(
            loginButton.frame, to: self.view
        ).maxY + 10 - displayHeight

        view.frame.origin.y == 0 ? (view.frame.origin.y -= bottomOffsetY) : ()
    }

    func keyboardDismiss(_ height: CGFloat) {
        view.frame.origin.y != 0 ? (view.frame.origin.y = 0) : ()
    }
}

extension LoginViewController: NavigationBarConfiguration {

    var navigationTitle: String? {
        Resources.Strings.Naviagtion.login
    }
}

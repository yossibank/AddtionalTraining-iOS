//
//  SignupViewController.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/13.
//

import UIKit
import Combine

final class SignupViewController: UIViewController {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confimPasswordTextField: UITextField!
    @IBOutlet private weak var validateEmailLabel: UILabel!
    @IBOutlet private weak var validatePasswordLabel: UILabel!
    @IBOutlet private weak var validateConfirmPasswordLabel: UILabel!
    @IBOutlet private weak var signupButton: UIButton!

    var keyboardNotifier: KeyboardNotifier = KeyboardNotifier()

    private let router: RouterProtocol = Router()

    private var viewModel: SignupViewModel!
    private var cancellables: Set<AnyCancellable> = .init()

    static func createInstance(viewModel: SignupViewModel) -> SignupViewController {
        let instance = SignupViewController.instantiateInitialViewController()
        instance.viewModel = viewModel
        return instance
    }

    @IBAction private func showBookListScreen(_ sender: Any) {
        
    }

    @IBAction private func showLoginScreen(_ sender: Any) {
        router.dismiss(self, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listenerKeyboard(keyboardNotifier: keyboardNotifier)
        bindValue()
        bindViewModel()
    }
}

extension SignupViewController {

    private func bindValue() {
        emailTextField.textDidChnagePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.email, on: viewModel)
            .store(in: &cancellables)

        passwordTextField.textDidChnagePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellables)

        confimPasswordTextField.textDidChnagePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.confirmPassword, on: viewModel)
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

        viewModel.$confirmPassword
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.validateConfirmPasswordLabel.text = self.viewModel.validationConfirmPasswordText
            }
            .store(in: &cancellables)

        Publishers
            .CombineLatest3(viewModel.$email, viewModel.$password, viewModel.$confirmPassword)
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .map { _ in self.viewModel.shouldEnabledButton() }
            .sink { [weak self] isEnabled in
                guard let self = self else { return }

                self.signupButton.alpha = isEnabled ? 1.0 : 0.5
                self.signupButton.isEnabled = isEnabled
            }
            .store(in: &cancellables)
    }
}

extension SignupViewController {

    override func touchesBegan(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        view.endEditing(true)
    }
}

extension SignupViewController: KeyboardDelegate {

    func keyboardPresent(_ height: CGFloat) {
        let displayHeight = view.frame.height - height
        let bottomOffsetY = stackView.convert(
            signupButton.frame, to: self.view
        ).maxY + 10 - displayHeight

        view.frame.origin.y == 0 ? (view.frame.origin.y -= bottomOffsetY) : ()
    }

    func keyboardDismiss(_ height: CGFloat) {
        view.frame.origin.y != 0 ? (view.frame.origin.y = 0) : ()
    }
}

extension SignupViewController: NavigationBarConfiguration {

    var navigationTitle: String? {
        Resources.Strings.Naviagtion.signup
    }
}

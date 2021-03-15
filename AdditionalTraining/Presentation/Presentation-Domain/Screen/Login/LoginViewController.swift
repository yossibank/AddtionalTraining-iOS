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
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!

    var keyboardNotifier: KeyboardNotifier = KeyboardNotifier()

    private let router: RouterProtocol = Router()

    private var isEnabled: Bool = false {
        didSet {
            loginButton.alpha = isEnabled ? 1.0 : 0.5
            loginButton.isEnabled = isEnabled
        }
    }

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
        setupTextField()
        bindValue()
        bindViewModel()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setupTextField() {
        [emailTextField, passwordTextField].forEach {
            $0?.delegate = self
        }
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
        viewModel.isEnabledButton
            .assign(to: \.isEnabled, on: self)
            .store(in: &cancellables)

        viewModel.$email
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .dropFirst()
            .map { _ in self.viewModel.validationEmailText }
            .assign(to: \.text, on: validateEmailLabel)
            .store(in: &cancellables)

        viewModel.$password
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .dropFirst()
            .map { _ in self.viewModel.validationPasswordText }
            .assign(to: \.text, on: validatePasswordLabel)
            .store(in: &cancellables)

        viewModel.$newWorkState
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                guard let self = self else { return }

                switch state {

                case .standby: break

                case .loading:
                    self.loadingIndicator.startAnimating()

                case .finished:
                    self.loadingIndicator.stopAnimating()
                    // TODO: show main tab controller

                case .error(let error):
                    self.loadingIndicator.stopAnimating()
                    self.showError(error: error)

                }
            }
            .store(in: &cancellables)
    }
}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textFields = [emailTextField, passwordTextField]

        guard
            let currentTextFieldIndex = textFields.firstIndex(of: textField)
        else {
            return false
        }

        if currentTextFieldIndex + 1 == textFields.endIndex {
            textField.resignFirstResponder()
        } else {
            textFields[currentTextFieldIndex + 1]?.becomeFirstResponder()
        }

        return true
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

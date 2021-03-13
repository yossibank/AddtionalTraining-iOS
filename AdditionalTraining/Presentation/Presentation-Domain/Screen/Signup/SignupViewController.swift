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

    private var cancellables: Set<AnyCancellable> = .init()

    static func createInstance() -> SignupViewController {
        let instance = SignupViewController.instantiateInitialViewController()
        return instance
    }

    @IBAction private func showLoginScreen(_ sender: Any) {
        router.dismiss(self, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listenerKeyboard(keyboardNotifier: keyboardNotifier)
        bindValue()
    }
}

extension SignupViewController {

    private func bindValue() {
        emailTextField.textDidChnagePublisher
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] text in
                guard let self = self else { return }

                let validationText = EmailValidator.validate(text).errorDescription
                self.validateEmailLabel.text = (validationText ?? .blank).isEmpty ? .blank : validationText
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

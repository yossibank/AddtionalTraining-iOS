//
//  KeyboardDelegate.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/13.
//

import UIKit
import Combine

final class KeyboardNotifier {

    var keyboardPresent: ((_ height: CGFloat) -> Void)?
    var keyboardDismiss: ((_ height: CGFloat) -> Void)?

    private var cancellables: Set<AnyCancellable> = .init()

    func listenKeyboard() {
        NotificationCenter
            .default
            .publisher(for: UIApplication.keyboardWillChangeFrameNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
            .sink { keyboardFrame in
                let keyboardHeight = UIScreen.main.bounds.height - keyboardFrame.origin.y
                if keyboardHeight > 0 {
                    self.keyboardPresent?(keyboardHeight)
                } else {
                    self.keyboardDismiss?(keyboardHeight)
                }
            }
            .store(in: &cancellables)
    }
}

protocol KeyboardDelegate: AnyObject {

    var keyboardNotifier: KeyboardNotifier { get set }

    func keyboardPresent(_ height: CGFloat)
    func keyboardDismiss(_ height: CGFloat)
}

extension KeyboardDelegate {

    func listenerKeyboard(keyboardNotifier: KeyboardNotifier) {
        keyboardNotifier.listenKeyboard()

        keyboardNotifier.keyboardPresent = { height in
            self.keyboardPresent(height)
        }

        keyboardNotifier.keyboardDismiss = { height in
            self.keyboardDismiss(height)
        }
    }
}

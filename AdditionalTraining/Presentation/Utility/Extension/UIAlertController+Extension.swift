//
//  UIAlertController+Extension.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/14.
//

import UIKit

extension UIAlertController {

    static func okAlert(
        title: String,
        message: String,
        completion: VoidBlock? = nil
    ) -> UIAlertController {

        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(
            title: Resources.Strings.Alert.okay,
            style: .cancel
        ) { _ in
            if let completion = completion {
                completion()
            }
        }

        return alert
    }

    private func addAction(
        title: String?,
        style: UIAlertAction.Style = .default,
        handler: ((UIAlertAction) -> Void)? = nil
    ) {
        let action = UIAlertAction(
            title: title,
            style: style,
            handler: handler
        )
        self.addAction(action)
    }
}

//
//  UIViewController+Extension.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/14.
//

import UIKit

extension UIViewController {

    func showError(error: Error) {

        var message: String

        if let apiError = error as? APIError, case .httpError(let httpCode) = apiError {
            message = apiError.httpCodeErrorMessage(httpCode: httpCode)
        } else {
            message = (error as? APIError)?.errorDescription ?? Resources.Strings.Error.unknownError
        }

        let alert = UIAlertController.okAlert(
            title: Resources.Strings.Alert.error,
            message: message
        )

        self.present(alert, animated: true)
    }
}

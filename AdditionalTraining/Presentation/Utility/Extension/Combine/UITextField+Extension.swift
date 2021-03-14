//
//  UITextField+Extension.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/13.
//

import UIKit
import Combine

extension UITextField {

    var textDidChnagePublisher: AnyPublisher<String, Never> {
        NotificationCenter
            .default
            .publisher(
                for: UITextField.textDidChangeNotification,
                object: self
            )
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? .blank }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}

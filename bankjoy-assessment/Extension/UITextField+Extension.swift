//
//  UITextField+Extension.swift
//  bankjoy-assessment
//
//  Created by Jude Botchwey on 2025-01-05.
//

import Foundation
import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
}

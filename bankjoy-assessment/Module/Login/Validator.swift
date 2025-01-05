//
//  Validator.swift
//  bankjoy-assessment
//
//  Created by Jude Botchwey on 2025-01-05.
//

import Foundation

enum ValidationResult {
    case success
    case failure(String)
}

struct ValidationConstants {
    struct Patterns {
        static let username = "[A-Za-z0-9_]{5,}"
        static let password = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!@#$%^&*]).{8,}$"
    }
    
    struct Messages {
        static let message = "Your username or password is incorrect. Please, try again."
    }
}

protocol ValidatorType {
    func validate(_ value: String, with pattern: String, message: String) -> ValidationResult
}

class Validator: ValidatorType {
    func validate(_ value: String, with pattern: String, message: String) -> ValidationResult {
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with: value) ? .success : .failure(message)
    }
}

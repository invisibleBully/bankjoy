//
//  Validator.swift
//  bankjoy-assessment
//
//  Created by Jude Botchwey on 2025-01-05.
//

import Foundation

enum ValidationResult: Equatable {
    case success
    case failure(String)
}

struct ValidationConstants {
    struct Patterns {
        static let username = "[A-Za-z0-9_]{5,}"
        static let password = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!@#$%^&*]).{8,}$"
    }
    
    struct Messages {
        static let username = "Your username must be at least 5 characters and include only letters, numbers, or underscores."
        static let password = "Your password must be 8+ characters with an uppercase, lowercase, number, and special character."
        static let usernameAndPassword = "Username: 5+ chars (letters, numbers, _). Password: 8+ chars, mix of cases, number, special char."

    }
}

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
        static let username = "Your username is incorrect. Please, try again."
        static let password = "Your password is incorrect. Please, try again."
        static let usernameAndPassword = "Your username and password are incorrect. Please, try again."
    }
}

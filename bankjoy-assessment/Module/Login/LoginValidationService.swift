//
//  LoginValidationService.swift
//  bankjoy-assessment
//
//  Created by Jude Botchwey on 2025-01-05.
//

import Foundation
import Combine

protocol ValidationServiceType {
    func validateUsername(_ username: String) -> AnyPublisher<ValidationResult, Never>
    func validatePassword(_ password: String) -> AnyPublisher<ValidationResult, Never>
}

class ValidationService: ValidationServiceType {
    private let validator: ValidatorType
    
    init(validator: ValidatorType) {
        self.validator = validator
    }
    
    private struct Patterns {
        static let username = "[A-Za-z0-9_]{5,}"
        static let password = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!@#$%^&*]).{8,}$"
    }
    
    func validateUsername(_ username: String) -> AnyPublisher<ValidationResult, Never> {
        return Just(validator.validate(username, with: Patterns.username, message: ValidationConstants.Messages.message))
            .eraseToAnyPublisher()
    }
    
    func validatePassword(_ password: String) -> AnyPublisher<ValidationResult, Never> {
        return Just(validator.validate(password, with: Patterns.password, message: ValidationConstants.Messages.message))
            .eraseToAnyPublisher()
    }
}






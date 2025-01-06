//
//  LoginValidationService.swift
//  bankjoy-assessment
//
//  Created by Jude Botchwey on 2025-01-05.
//

import Foundation
import Combine

protocol ValidatorType {
    func validate(_ value: String, with pattern: String, message: String) -> ValidationResult
}

class Validator: ValidatorType {
    func validate(_ value: String, with pattern: String, message: String) -> ValidationResult {
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with: value) ? .success : .failure(message)
    }
}

protocol ValidationServiceType {
    func validateUsername(_ username: String) -> AnyPublisher<ValidationResult, Never>
    func validatePassword(_ password: String) -> AnyPublisher<ValidationResult, Never>
}

class ValidationService: ValidationServiceType {
    private let validator: ValidatorType
    
    init(validator: ValidatorType = Validator()) {
        self.validator = validator
    }
    
    func validateUsername(_ username: String) -> AnyPublisher<ValidationResult, Never> {
        if username.isEmpty {
            return Just(.failure(ValidationConstants.Messages.username)).eraseToAnyPublisher()
        }
        
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: username)) {
            return Just(.failure(ValidationConstants.Messages.username)).eraseToAnyPublisher()
        }
        
        let result = validator.validate(username,
                                        with: ValidationConstants.Patterns.username,
                                        message: ValidationConstants.Messages.username)
        return Just(result).eraseToAnyPublisher()
    }
    
    func validatePassword(_ password: String) -> AnyPublisher<ValidationResult, Never> {
        if password.isEmpty {
            return Just(.failure(ValidationConstants.Messages.password)).eraseToAnyPublisher()
        }
        
        let result = validator.validate(password,
                                        with: ValidationConstants.Patterns.password,
                                        message: ValidationConstants.Messages.password)
        return Just(result).eraseToAnyPublisher()
    }
}

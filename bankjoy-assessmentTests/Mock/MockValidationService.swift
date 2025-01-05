//
//  MockValidationService.swift
//  bankjoy-assessmentTests
//
//  Created by Jude Botchwey on 2025-01-05.
//

import XCTest
import Combine
@testable import bankjoy_assessment

class MockValidator: ValidatorType {
    func validate(_ value: String, with pattern: String, message: String) -> ValidationResult {
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with: value) ? .success : .failure(message)
    }
}

class MockValidationService: ValidationServiceType {
    private let validator: ValidatorType
    
    init(validator: ValidatorType) {
        self.validator = validator
    }
    
    func validateUsername(_ username: String) -> AnyPublisher<ValidationResult, Never> {
        return Just(validator.validate(username, with: ValidationConstants.Patterns.username, message: ValidationConstants.Messages.message))
            .eraseToAnyPublisher()
    }
    
    func validatePassword(_ password: String) -> AnyPublisher<ValidationResult, Never> {
        return Just(validator.validate(password, with: ValidationConstants.Patterns.password, message: ValidationConstants.Messages.message))
            .eraseToAnyPublisher()
    }
}

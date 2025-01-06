//
//  ValidationServiceTests.swift
//  bankjoy-assessmentTests
//
//  Created by Jude Botchwey on 2025-01-05.
//

import XCTest
import Combine
@testable import bankjoy_assessment

class ValidationServiceTests: XCTestCase {
    private var validationService: ValidationService!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        validationService = ValidationService()
        cancellables = []
    }

    override func tearDown() {
        validationService = nil
        cancellables = nil
        super.tearDown()
    }

    func testEmptyUsernameValidation() {
        let expectation = XCTestExpectation(description: "Validation should fail for empty username")

        validationService.validateUsername("")
            .sink { result in
                XCTAssertEqual(result, .failure(ValidationConstants.Messages.username))
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testValidUsernameValidation() {
        let expectation = XCTestExpectation(description: "Validation should pass for valid username")

        validationService.validateUsername("validUser")
            .sink { result in
                XCTAssertEqual(result, .success)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testEmptyPasswordValidation() {
        let expectation = XCTestExpectation(description: "Validation should fail for empty password")

        validationService.validatePassword("")
            .sink { result in
                XCTAssertEqual(result, .failure(ValidationConstants.Messages.password))
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testValidPasswordValidation() {
        let expectation = XCTestExpectation(description: "Validation should pass for valid password")

        validationService.validatePassword("Valid123A@")
            .sink { result in
                XCTAssertEqual(result, .success)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}

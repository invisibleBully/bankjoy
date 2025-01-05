//
//  LoginViewModelTests.swift
//  bankjoy-assessmentTests
//
//  Created by Jude Botchwey on 2025-01-05.
//

import XCTest
import Combine
@testable import bankjoy_assessment

class LoginiewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        let mockValidator = MockValidator()
        let mockValidationService = MockValidationService(validator: mockValidator)
        viewModel = LoginViewModel(validationService: mockValidationService)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testValidUser() {
        let user = User.mockValidUser()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertTrue(viewModel.isValid)
        XCTAssertEqual(viewModel.alertMessage, "")
    }
    
    func testInvalidUsername() {
        let user = User.mockInvalidUsername()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertFalse(viewModel.isValid)
        XCTAssertEqual(viewModel.alertMessage, "Your username or password is incorrect. Please, try again.")
    }
    
    func testInvalidPassword() {
        let user = User.mockInvalidPassword()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertFalse(viewModel.isValid)
        XCTAssertEqual(viewModel.alertMessage, "Your username or password is incorrect. Please, try again.")
    }
    
    func testPasswordWithoutSpecialCharacter() {
        let user = User.mockPasswordWithoutSpecialCharacter()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertFalse(viewModel.isValid)
        XCTAssertEqual(viewModel.alertMessage, "Your username or password is incorrect. Please, try again.")
    }
    
    func testPasswordWithoutNumber() {
        let user = User.mockPasswordWithoutNumber()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertFalse(viewModel.isValid)
        XCTAssertEqual(viewModel.alertMessage, "Your username or password is incorrect. Please, try again.")
    }
    
    func testShortPassword() {
        let user = User.mockShortPassword()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertFalse(viewModel.isValid)
        XCTAssertEqual(viewModel.alertMessage, "Your username or password is incorrect. Please, try again.")
    }
}

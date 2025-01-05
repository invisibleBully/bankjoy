//
//  LoginViewModelTests.swift
//  bankjoy-assessmentTests
//
//  Created by Jude Botchwey on 2025-01-05.
//

import XCTest
import Combine
@testable import bankjoy_assessment

class LoginViewModelTests: XCTestCase {
    
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
        
        XCTAssertTrue(viewModel.isUsernameValid)
        XCTAssertTrue(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "")
    }
    
    func testInvalidUsername() {
        let user = User.mockInvalidUsername()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertFalse(viewModel.isUsernameValid)
        XCTAssertTrue(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Your username is incorrect. Please, try again.")
    }
    
    func testInvalidPassword() {
        let user = User.mockInvalidPassword()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertTrue(viewModel.isUsernameValid)
        XCTAssertFalse(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Your password is incorrect. Please, try again.")
    }
    
    func testPasswordWithoutSpecialCharacter() {
        let user = User.mockPasswordWithoutSpecialCharacter()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertTrue(viewModel.isUsernameValid)
        XCTAssertFalse(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Your password is incorrect. Please, try again.")
    }
    
    func testPasswordWithoutNumber() {
        let user = User.mockPasswordWithoutNumber()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertTrue(viewModel.isUsernameValid)
        XCTAssertFalse(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Your password is incorrect. Please, try again.")
    }
    
    func testShortPassword() {
        let user = User.mockShortPassword()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertTrue(viewModel.isUsernameValid)
        XCTAssertFalse(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Your password is incorrect. Please, try again.")
    }
    
    func testEmptyUsername() {
        let user = User.mockEmptyUserName()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertFalse(viewModel.isUsernameValid)
        XCTAssertTrue(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Your username is incorrect. Please, try again.")
    }
    
    func testEmptyPassword() {
        let user = User.mockEmptyPassword()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertTrue(viewModel.isUsernameValid)
        XCTAssertFalse(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Your password is incorrect. Please, try again.")
    }
    
    
    func testEmptyUsernameAndPassword() {
        let user = User.mockEmptyUserNameAndPassword()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertFalse(viewModel.isUsernameValid)
        XCTAssertFalse(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Your username and password are incorrect. Please, try again.")
    }
}

//
//  LoginViewModelTests.swift
//  bankjoy-assessmentTests
//
//  Created by Jude Botchwey on 2025-01-05.
//

import XCTest
import Combine
@testable import bankjoy_assessment

class UserViewModelTests: XCTestCase {
    
    var viewModel: UserViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        let mockValidator = MockValidator()
        let mockValidationService = MockValidationService(validator: mockValidator)
        viewModel = UserViewModel(validationService: mockValidationService)
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
        XCTAssertEqual(viewModel.alertMessage, "Your username must be at least 5 characters and include only letters, numbers, or underscores.")
    }
    
    func testInvalidPassword() {
        let user = User.mockInvalidPassword()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertTrue(viewModel.isUsernameValid)
        XCTAssertFalse(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Your password must be 8+ characters with an uppercase, lowercase, number, and special character.")
    }
    
    func testPasswordWithoutSpecialCharacter() {
        let user = User.mockPasswordWithoutSpecialCharacter()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertTrue(viewModel.isUsernameValid)
        XCTAssertFalse(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Your password must be 8+ characters with an uppercase, lowercase, number, and special character.")
    }
    
    func testPasswordWithoutNumber() {
        let user = User.mockPasswordWithoutNumber()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertTrue(viewModel.isUsernameValid)
        XCTAssertFalse(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Your password must be 8+ characters with an uppercase, lowercase, number, and special character.")
    }
    
    func testShortPassword() {
        let user = User.mockShortPassword()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertTrue(viewModel.isUsernameValid)
        XCTAssertFalse(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Your password must be 8+ characters with an uppercase, lowercase, number, and special character.")
    }
    
    func testEmptyUsername() {
        let user = User.mockEmptyUserName()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertFalse(viewModel.isUsernameValid)
        XCTAssertTrue(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Your username must be at least 5 characters and include only letters, numbers, or underscores.")
    }
    
    func testEmptyPassword() {
        let user = User.mockEmptyPassword()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertTrue(viewModel.isUsernameValid)
        XCTAssertFalse(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Your password must be 8+ characters with an uppercase, lowercase, number, and special character.")
    }
    
    
    func testEmptyUsernameAndPassword() {
        let user = User.mockEmptyUserNameAndPassword()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertFalse(viewModel.isUsernameValid)
        XCTAssertFalse(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Username: 5+ chars (letters, numbers, _). Password: 8+ chars, mix of cases, number, special char.")
    }
    
    func testUsernameWithSpecialCharacters() {
        let user = User.mockUserNameWithSpecialCharacters()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertFalse(viewModel.isUsernameValid)
        XCTAssertTrue(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Your username must be at least 5 characters and include only letters, numbers, or underscores.")
    }
    
    func testPasswordWithOnlyNumbers() {
        let user = User.mockPasswordWithOnlyNumbers()
        viewModel.username = user.username
        viewModel.password = user.password
        
        XCTAssertTrue(viewModel.isUsernameValid)
        XCTAssertFalse(viewModel.isPasswordValid)
        XCTAssertEqual(viewModel.alertMessage, "Your password must be 8+ characters with an uppercase, lowercase, number, and special character.")
    }
    
}

//
//  MockUser.swift
//  bankjoy-assessmentTests
//
//  Created by Jude Botchwey on 2025-01-05.
//

import XCTest
@testable import bankjoy_assessment

extension User {
    static func mockValidUser() -> User {
        return User(
            username: "_validUser",
            password: "ValidPassword123!"
        )
    }
    
    static func mockInvalidUsername() -> User {
        return User(
            username: "user",
            password: "ValidPassword123!"
        )
    }
    
    static func mockInvalidPassword() -> User {
        return User(
            username: "validUser",
            password: "password"
        )
    }
    
    static func mockPasswordWithoutSpecialCharacter() -> User {
        return User(
            username: "validUser",
            password: "ValidPassword123"
        )
    }
    
    static func mockPasswordWithoutNumber() -> User {
        return User(
            username: "validUser",
            password: "ValidPassword!"
        )
    }
    
    static func mockShortPassword() -> User {
        return User(
            username: "validUser",
            password: "Val1d!"
        )
    }
}


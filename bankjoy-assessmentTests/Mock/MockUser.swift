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
            username: "",
            password: "$Adm1n!@205455"
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
    
    static func mockEmptyUserName() -> User {
        return User(
            username: "",
            password: "$Adm1n!@2023"
        )
    }
    
    static func mockEmptyPassword() -> User {
        return User(
            username: "validUser",
            password: ""
        )
    }
    
    static func mockEmptyUserNameAndPassword() -> User {
        return User(
            username: "",
            password: ""
        )
    }
    
    static func mockUserNameWithSpecialCharacters() -> User {
        return User(
            username: "$Adm1n!@2024",
            password: "$Adm1n!@2024"
        )
    }
    
    static func mockPasswordWithOnlyNumbers() -> User {
        return User(
            username: "validUser",
            password: "1234567890"
        )
    }
    
}


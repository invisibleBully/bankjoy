//
//  LoginViewModel.swift
//  bankjoy-assessment
//
//  Created by Jude Botchwey on 2025-01-04.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isValid: Bool = true
    @Published var alertMessage: String = ""
    
    private var validationService: ValidationServiceType
    private var cancellables = Set<AnyCancellable>()
    
    init(validationService: ValidationServiceType) {
        self.validationService = validationService
        
        Publishers.CombineLatest($username, $password)
            .flatMap { [unowned self] username, password in
                self.validateCredentials(username: username, password: password)
            }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)
        
        $isValid
            .map { $0 ? "" : "Your username or password is incorrect. Please, try again." }
            .assign(to: \.alertMessage, on: self)
            .store(in: &cancellables)
    }
    
    private func validateCredentials(username: String, password: String) -> AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(
            validationService.validateUsername(username),
            validationService.validatePassword(password)
        )
        .map { usernameResult, passwordResult in
            self.handleValidationResult(
                usernameResult: usernameResult,
                passwordResult: passwordResult
            )
        }
        .eraseToAnyPublisher()
    }
    
    private func handleValidationResult(
        usernameResult: ValidationResult,
        passwordResult: ValidationResult) -> Bool {
            
            switch (usernameResult, passwordResult) {
            case (.success, .success):
                self.alertMessage = ""
                return true
            case (.failure(let message), _):
                self.alertMessage = message
                return false
            case (_, .failure(let message)):
                self.alertMessage = message
                return false
            }
        }
}

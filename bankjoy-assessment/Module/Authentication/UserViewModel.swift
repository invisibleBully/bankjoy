//
//  LoginViewModel.swift
//  bankjoy-assessment
//
//  Created by Jude Botchwey on 2025-01-04.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var alertMessage: String = ""
    @Published var isUsernameValid: Bool = false
    @Published var isPasswordValid: Bool = false
    
    private var validationService: ValidationServiceType
    private var cancellables = Set<AnyCancellable>()
    
    init(validationService: ValidationServiceType) {
        self.validationService = validationService
        setupBinding()
    }
    
    private func setupBinding(){
        $username
            .dropFirst()
            .flatMap { [unowned self] username in
                self.validateUsername(username)
            }
            .sink { [weak self] validationResult in
                self?.handleUsernameValidationResult(validationResult)
                self?.validatePasswordIfNeeded()
            }
            .store(in: &cancellables)
        
        $password
            .dropFirst()
            .flatMap { [unowned self] password in
                self.validatePassword(password)
            }
            .sink { [weak self] validationResult in
                self?.handlePasswordValidationResult(validationResult)
                self?.validateUsernameIfNeeded()
            }
            .store(in: &cancellables)
    }
    
    private func validateUsername(_ username: String) -> AnyPublisher<ValidationResult, Never> {
        return validationService.validateUsername(username)
    }
    
    private func validatePassword(_ password: String) -> AnyPublisher<ValidationResult, Never> {
        return validationService.validatePassword(password)
    }
    
    private func handleUsernameValidationResult(_ result: ValidationResult) {
        switch result {
        case .success:
            self.isUsernameValid = true
        case .failure:
            self.isUsernameValid = false
        }
        updateAlertMessage()
    }
    
    private func handlePasswordValidationResult(_ result: ValidationResult) {
        switch result {
        case .success:
            self.isPasswordValid = true
        case .failure:
            self.isPasswordValid = false
        }
        updateAlertMessage()
    }
    
    private func validatePasswordIfNeeded() {
        let passwordPublisher = validatePassword(password)
        passwordPublisher.sink { [weak self] validationResult in
            self?.handlePasswordValidationResult(validationResult)
        }
        .store(in: &cancellables)
    }
    
    private func validateUsernameIfNeeded() {
        let usernamePublisher = validateUsername(username)
        usernamePublisher.sink { [weak self] validationResult in
            self?.handleUsernameValidationResult(validationResult)
        }
        .store(in: &cancellables)
    }
    
    private func updateAlertMessage() {
        if !isUsernameValid && !isPasswordValid {
            alertMessage = ValidationConstants.Messages.usernameAndPassword
        } else if !isUsernameValid {
            alertMessage = ValidationConstants.Messages.username
        } else if !isPasswordValid {
            alertMessage = ValidationConstants.Messages.password
        } else {
            alertMessage = ""
        }
    }
}

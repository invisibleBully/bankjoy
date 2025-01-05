//
//  ViewController.swift
//  bankjoy-assessment
//
//  Created by Jude Botchwey on 2025-01-04.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    
    private var viewModel: UserViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    private let alertLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, alertLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        usernameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    private func bindViewModel() {
        viewModel.$isUsernameValid
            .dropFirst()
            .sink { [weak self] isValid in
                guard let self = self else { return }
                self.usernameTextField.layer.borderColor = isValid ? UIColor.green.cgColor : UIColor.red.cgColor
                self.usernameTextField.layer.borderWidth = 1
            }
            .store(in: &cancellables)
        
        viewModel.$isPasswordValid
            .dropFirst()
            .sink { [weak self] isValid in
                guard let self = self else { return }
                self.passwordTextField.layer.borderColor = isValid ? UIColor.green.cgColor : UIColor.red.cgColor
                self.passwordTextField.layer.borderWidth = 1
            }
            .store(in: &cancellables)
        
        viewModel.$alertMessage
            .dropFirst()
            .sink { [weak self] alertMessage in
                guard let self = self else { return }
                self.alertLabel.text = alertMessage
                self.alertLabel.isHidden = alertMessage.isEmpty
            }
            .store(in: &cancellables)
    }
    
    @objc private func textFieldChanged(_ textField: UITextField) {
        if textField === usernameTextField {
            viewModel.username = textField.text ?? ""
        } else if textField === passwordTextField {
            viewModel.password = textField.text ?? ""
        }
    }
}

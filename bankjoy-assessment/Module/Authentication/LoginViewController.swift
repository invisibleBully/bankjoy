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
    
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "bg"))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Username"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "eg. _a_user234"
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "eg. $Adm1n!@0000"
        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return textField
    }()
    
    private lazy var usernameBottomBorder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var passwordBottomBorder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.isHidden = true
        return label
    }()
    
    private lazy var helpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.darkText, for: .normal)
        button.setTitle("Help?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()
    
    private let rememberMeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" Remember me", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.tintColor = .blue
        button.contentHorizontalAlignment = .leading
        button.addTarget(self, action: #selector(didTapRememberMe), for: .touchUpInside)
        return button
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.darkText, for: .normal)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 24
        button.isEnabled = false
        return button
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buttonOne: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.darkText, for: .normal)
        button.setTitle("Button 1", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return button
    }()
    
    private lazy var buttonTwo: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.darkText, for: .normal)
        button.setTitle("Button 2", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return button
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(backgroundImageView)
        view.addSubview(containerView)
        
        containerView.addSubview(usernameLabel)
        containerView.addSubview(usernameTextField)
        containerView.addSubview(usernameBottomBorder)
        containerView.addSubview(passwordLabel)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(passwordBottomBorder)
        containerView.addSubview(alertLabel)
        containerView.addSubview(helpButton)
        containerView.addSubview(rememberMeButton)
        containerView.addSubview(continueButton)
        containerView.addSubview(dividerView)
        containerView.addSubview(buttonOne)
        containerView.addSubview(buttonTwo)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: containerView.topAnchor),
            
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            usernameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32),
            
            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor),
            usernameTextField.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32),
            usernameTextField.heightAnchor.constraint(equalToConstant: 48),
            
            usernameBottomBorder.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor),
            usernameBottomBorder.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            usernameBottomBorder.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            usernameBottomBorder.heightAnchor.constraint(equalToConstant: 1),
            
            passwordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 32),
            passwordLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordBottomBorder.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            passwordBottomBorder.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            passwordBottomBorder.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            passwordBottomBorder.heightAnchor.constraint(equalToConstant: 1),
            
            alertLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 4),
            alertLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            alertLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -16),
            
            helpButton.topAnchor.constraint(equalTo: alertLabel.bottomAnchor, constant: 16),
            helpButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32),
            
            rememberMeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            rememberMeButton.topAnchor.constraint(equalTo: alertLabel.bottomAnchor, constant: 16),
            rememberMeButton.heightAnchor.constraint(equalToConstant: 40),
            
            continueButton.heightAnchor.constraint(equalToConstant: 48),
            continueButton.topAnchor.constraint(equalTo: helpButton.bottomAnchor, constant: 24),
            continueButton.leadingAnchor.constraint(equalTo: rememberMeButton.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: helpButton.trailingAnchor),
            
            dividerView.widthAnchor.constraint(equalToConstant: 1),
            dividerView.heightAnchor.constraint(equalToConstant: 30),
            dividerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            dividerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            buttonOne.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            buttonOne.trailingAnchor.constraint(equalTo: dividerView.leadingAnchor),
            buttonOne.centerYAnchor.constraint(equalTo: dividerView.centerYAnchor),
            buttonOne.heightAnchor.constraint(equalToConstant: 38),
            
            buttonTwo.leadingAnchor.constraint(equalTo: dividerView.trailingAnchor),
            buttonTwo.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            buttonTwo.centerYAnchor.constraint(equalTo: dividerView.centerYAnchor),
            buttonTwo.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        usernameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    private func bindViewModel() {
        viewModel.$isUsernameValid
            .dropFirst()
            .sink { [weak self] isValid in
                guard let self = self else { return }
                self.usernameTextField.textColor = isValid ? .darkGray : .red
                self.usernameBottomBorder.backgroundColor = isValid ? .green : .red
            }
            .store(in: &cancellables)
        
        viewModel.$isPasswordValid
            .dropFirst()
            .sink { [weak self] isValid in
                guard let self = self else { return }
                self.passwordBottomBorder.backgroundColor = isValid ? .green : .red
                self.passwordTextField.textColor = isValid ? .darkGray : .red
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
        
        Publishers.CombineLatest(viewModel.$isUsernameValid,
                                 viewModel.$isPasswordValid)
        .sink { [weak self] isUsernameValid, isPasswordValid in
            guard let self = self else { return }
            let isEnabled = isUsernameValid && isPasswordValid
            self.continueButton.isEnabled = isEnabled
            self.continueButton.backgroundColor = isEnabled ? .black : .lightGray
            self.continueButton.setTitleColor(isEnabled ? .white : .darkText, for: .normal)
        }
        .store(in: &cancellables)
    }
    
    @objc private func didTapRememberMe() {
        let isSelected = rememberMeButton.imageView?.image == UIImage(systemName: "checkmark.circle.fill")
        
        let newImage = isSelected ? UIImage(systemName: "circle") : UIImage(systemName: "checkmark.circle.fill")
        rememberMeButton.setImage(newImage, for: .normal)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height
        
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight / 2)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = .identity
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func textFieldChanged(_ textField: UITextField) {
        if textField == usernameTextField {
            viewModel.username = textField.text ?? ""
        } else if textField == passwordTextField {
            viewModel.password = textField.text ?? ""
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

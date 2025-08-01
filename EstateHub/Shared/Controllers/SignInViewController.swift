//
//  SignInViewController.swift
//  EstateHub
//
//  Created by Unit27 on 25/07/2025.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let emailTextField =  DefaultTextField(placeholder: "Wpisz adres e-mail")
    private let passwordTextField =  DefaultTextField(placeholder: "Wpisz hasło")
    private lazy var nextButton = DefaultButton(title: "Zaloguj", target: self, action: #selector(nextButtonTapped))
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(nextButton)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            nextButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func nextButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
            Alerts.showError(on: self, message: "Proszę wpisać adres e-mail.")
            return
        }
        
        if isValidEmail(email) {
            print("Email poprawny: \(email)")
        } else {
            Alerts.showError(on: self, message: "Nieprawidłowy adres e-mail.")
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            Alerts.showError(on: self, message: "Proszę wpisać hasło")
            return
        }
    }
    
}

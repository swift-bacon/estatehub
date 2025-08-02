//
//  SignUpViewController.swift
//  EstateHub
//
//  Created by Unit27 on 25/07/2025.
//

import UIKit

class SignUpEmailViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private var titleText = BigTitleLabel(labelText: "Registration")
    private var descriptionText = DescriptionLabel(labelText: "Set email address")
    private let emailTextField =  DefaultTextField(placeholder: "Enter e-mail address")
    private lazy var nextButton = DefaultButton(title: "Next", target: self, action: #selector(nextButtonTapped))
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(titleText)
        view.addSubview(descriptionText)
        view.addSubview(emailTextField)
        view.addSubview(nextButton)
        
        titleText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 20),
            descriptionText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            nextButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func nextButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
            Alerts.showError(on: self, message: "Enter e-mail address")
            return
        }
        
        if isValidEmail(email) {
            let signUpPasswordViewController = SignUpPasswordViewController()
            signUpPasswordViewController.email = email
            navigationController?.pushViewController(signUpPasswordViewController, animated: true)
        } else {
            Alerts.showError(on: self, message: "Wrong e-mail address")
        }
    }
    
}


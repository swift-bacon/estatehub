//
//  SignUpPasswordViewController.swift
//  EstateHub
//
//  Created by Unit27 on 02/08/2025.
//
import UIKit

class SignUpPasswordViewController: UIViewController {
    
    // MARK: - Variables
    
    var email: String?
    
    // MARK: - UI Elements
    
    private var titleText = BigTitleLabel(labelText: "Registration")
    private var descriptionText = DescriptionLabel(labelText: "Set password")
    private let passwordTextField =  DefaultTextField(placeholder: "Enter password")
    private lazy var nextButton = DefaultButton(title: "Next", target: self, action: #selector(nextButtonTapped))
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
    
    // MARK: - Layout
    
    ///
    /// Setup layout
    ///
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(titleText)
        view.addSubview(descriptionText)
        view.addSubview(passwordTextField)
        view.addSubview(nextButton)
        
        titleText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 20),
            descriptionText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            nextButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func nextButtonTapped() {
        guard let password = passwordTextField.text, !password.isEmpty else {
            Alerts.showError(on: self, message: "Enter password")
            return
        }
        
        if let passwordError = isPasswordValid(password) {
            Alerts.showError(on: self, message: passwordError)
            return
        }
        
        let signUpAvatarViewController = SignUpAvatarViewController()
        signUpAvatarViewController.email = email
        signUpAvatarViewController.password = password
        navigationController?.pushViewController(signUpAvatarViewController, animated: true)
    }
    
}

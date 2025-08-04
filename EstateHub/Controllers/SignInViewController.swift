//
//  SignInViewController.swift
//  EstateHub
//
//  Created by Unit27 on 25/07/2025.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - UI Elements
    private var titleText = BigTitleLabel(labelText: "Login to \(appName)")
    private var descriptionText = DescriptionLabel(labelText: "Enter to the hub with best estates adverts list")
    private let textFieldsView = UIView()
    private let emailTextField =  DefaultTextField(placeholder: "Enter e-mail address")
    private let passwordTextField =  DefaultTextField(placeholder: "Enter password")
    private lazy var loginButton = DefaultButton(title: "Login", target: self, action: #selector(loginButtonTapped))
    
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
        view.addSubview(titleText)
        view.addSubview(descriptionText)
        view.addSubview(textFieldsView)
        textFieldsView.addSubview(emailTextField)
        textFieldsView.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        titleText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        textFieldsView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 20),
            descriptionText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            textFieldsView.heightAnchor.constraint(equalToConstant: 200),
            textFieldsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textFieldsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            textFieldsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            emailTextField.topAnchor.constraint(equalTo: textFieldsView.topAnchor, constant: 0),
            emailTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor, constant: 0),
            emailTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor, constant: 0),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
            passwordTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor, constant: 0),
            passwordTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor, constant: 0),
            
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func loginButtonTapped() {
        Task { [weak self] in
            await self?.handleLogin()
        }
    }
    
    ///
    /// Handle login method
    ///
    private func handleLogin() async {
        guard let email = emailTextField.text, !email.isEmpty else {
            Alerts.showError(on: self, message: "Enter e-mail address")
            return
        }

        guard let password = passwordTextField.text, !password.isEmpty else {
            Alerts.showError(on: self, message: "Enter password")
            return
        }

        do {
            try await AuthService.logUserIn(email: email, password: password)
            
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let dashboardVC = storyboard.instantiateViewController(withIdentifier: "DashboardViewController")

            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: dashboardVC)
            sceneDelegate.window?.makeKeyAndVisible()

        } catch {
            Alerts.showError(on: self, message: "Login error: \(error.localizedDescription)")
        }
    }
    
}

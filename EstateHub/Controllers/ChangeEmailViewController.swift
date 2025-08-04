//
//  ChangeEmailViewController.swift
//  EstateHub
//
//  Created by Unit27 on 04/08/2025.
//
import UIKit
import FirebaseAuth

class ChangeEmailViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "New Email"
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Current Password"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let changeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Change Email", for: .normal)
        btn.addTarget(self, action: #selector(changeEmailTapped), for: .touchUpInside)
        return btn
    }()
    
    private let cancelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Cancel", for: .normal)
        btn.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, changeButton, cancelButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func changeEmailTapped() {
        guard let newEmail = emailTextField.text, !newEmail.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }
        
        reauthenticateAndChangeEmail(newEmail: newEmail, currentPassword: password)
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    
    private func reauthenticateAndChangeEmail(newEmail: String, currentPassword: String) {
        guard let user = Auth.auth().currentUser,
              let email = user.email else {
            showAlert(message: "No logged-in user found.")
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        
        user.reauthenticate(with: credential) { [weak self] _, error in
            if let error = error {
                self?.showAlert(message: "Reauthentication failed: \(error.localizedDescription)")
                return
            }
            
            user.sendEmailVerification(beforeUpdatingEmail: newEmail) { error in
                if let error = error {
                    self?.showAlert(message: "Failed to send verification email: \(error.localizedDescription)")
                    return
                }
                
                DispatchQueue.main.async {
                    self?.showAlert(message: "Verification email sent to \(newEmail). Please verify before the change is applied.", completion: {
                        LocalUserStorage().updateEmail(newEmail: newEmail)
                        self?.dismiss(animated: true)
                        self?.handleLogout()
                    })
                }
            }
        }
    }
    
    ///
    /// Show alert
    ///
    private func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in completion?() })
        present(alert, animated: true)
    }
    
    ///
    /// Handle logout
    ///
    private func handleLogout() {
        do {
            try AuthService.logOut()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let startVC = storyboard.instantiateViewController(withIdentifier: "StartViewController")
            let navVC = UINavigationController(rootViewController: startVC)
            
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = navVC
                sceneDelegate.window?.makeKeyAndVisible()
            }

        } catch {
            Alerts.showError(on: self, message: "Logout error: \(error.localizedDescription)")
        }
    }
    
}

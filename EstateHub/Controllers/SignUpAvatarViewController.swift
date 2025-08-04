//
//  SignUpAvatarViewController.swift
//  EstateHub
//
//  Created by Unit27 on 02/08/2025.
//
import UIKit
import FirebaseAuth

class SignUpAvatarViewController: UIViewController {
    
    // MARK: - Variables
    
    var email: String?
    var password: String?
    
    // MARK: - UI Elements
    
    private var titleText = BigTitleLabel(labelText: "Registration")
    private var descriptionText = DescriptionLabel(labelText: "Set your avatar image (optional)")
    private var avatarImageView = AvatarImageView(frame: .zero)
    private lazy var registerButton = DefaultButton(title: "Register", target: self, action: #selector(registerButtonTapped))
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
    
    // MARK: - Setups
    
    ///
    /// Setup layout
    /// 
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(titleText)
        view.addSubview(descriptionText)
        view.addSubview(avatarImageView)
        
        avatarImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentActionSheet))
        avatarImageView.addGestureRecognizer(tapGesture)
        
        view.addSubview(registerButton)
        
        titleText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 20),
            descriptionText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            avatarImageView.heightAnchor.constraint(equalToConstant: 200),
            avatarImageView.widthAnchor.constraint(equalToConstant: 200),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            registerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Actions
    
    ///
    /// Register button tapped
    ///
    @objc private func registerButtonTapped() {
        guard let userEmail = email, !userEmail.isEmpty, let userPassword = password, !userPassword.isEmpty else {
            print("Registration failed, missing parameters")
            return
        }
        
        guard let selectedImage = avatarImageView.image else {
            Alerts.showError(on: self, message: "Please select an avatar image")
            return
        }
        
        Task {
            do {
               try await AuthService.registerUser(credentials: AuthCredentials(email: userEmail, password: userPassword, profileImage: selectedImage))
                
                LocalUserStorage.saveUser(email: userEmail, uid: Auth.auth().currentUser?.uid ?? "", avatarImage: selectedImage)
                
                let dashboardViewController = DashboardViewController()
                navigationController?.pushViewController(dashboardViewController, animated: true)
            } catch {
                Alerts.showError(on: self, message: "Registration failed: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Camera and media library
    
    ///
    /// Present action sheet
    ///
    @objc private func presentActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
            self?.presentPhotoLibrary()
        }))
        present(actionSheet, animated: true)
    }
    
    ///
    /// Present camera
    ///
    private func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    ///
    /// Present photo library
    ///
    private func presentPhotoLibrary() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
}

// MARK: - UIImagePickerControllerDelegate

extension SignUpAvatarViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        picker.dismiss(animated: true, completion: nil)
        avatarImageView.setImage(selectedImage)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UINavigationControllerDelegate

extension SignUpAvatarViewController: UINavigationControllerDelegate {}

//
//  UserProfileViewController.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import UIKit

class UserProfileViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
            avatarImageView.contentMode = .scaleAspectFill
            avatarImageView.clipsToBounds = true
            
            if let user = LocalUserStorage.loadUser(), let avatar = user.avatar {
                avatarImageView.image = avatar
            }
        }
    }
    @IBOutlet weak var userEmailLabel: UILabel! {
        didSet {
            userEmailLabel.text = LocalUserStorage.loadUser()?.email ?? "Anonymous"
        }
    }
    @IBOutlet weak var changeEmailButton: DefaultButton!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSetups()
    }
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
    
    // MARK: - Setups
    
    ///
    /// Layout setups
    /// 
    private func layoutSetups() {
        view.backgroundColor = .white
    }
    
    // MARK: - Actions
    
    @IBAction func onChangeEmailDidTapped(_ sender: Any) {
        let changeEmailVC = ChangeEmailViewController()
            changeEmailVC.modalPresentationStyle = .formSheet
            present(changeEmailVC, animated: true)
    }
    
}

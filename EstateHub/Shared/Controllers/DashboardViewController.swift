//
//  DashboardViewController.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import UIKit

class DashboardViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var addAdvertButton: UIButton!
    @IBOutlet weak var promotedAdvertsLabel: UILabel!
    @IBOutlet weak var advertsCollectionView: UICollectionView!
    @IBOutlet weak var allAdvertsLabel: UILabel!
    @IBOutlet weak var advertsTableView: UITableView!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    // MARK: - Setups
    
    private func setupLayout() {
        view.backgroundColor = .white
        title = appName
        
        setupProfileButton()
    }
    
    ///
    /// Setup profile button in navigation bar
    ///
    private func setupProfileButton() {
        let image = UIImage(systemName: "person.circle.fill")?.withRenderingMode(.alwaysTemplate)

           let profileButton = UIButton(type: .custom)
           profileButton.setImage(image, for: .normal)
           profileButton.tintColor = .label
           profileButton.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
           profileButton.contentMode = .scaleAspectFill
           profileButton.layer.cornerRadius = 18
           profileButton.clipsToBounds = true
           profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)

           let barButtonItem = UIBarButtonItem(customView: profileButton)
           navigationItem.rightBarButtonItem = barButtonItem
    }
    
    // MARK: - Actions
    
    @objc private func profileButtonTapped() {
        let userProfileViewController = UserProfileViewController()
        navigationController?.pushViewController(userProfileViewController, animated: true)
    }
    
    @IBAction func addAdvertButtonDidTapped(_ sender: Any) {}
    
}

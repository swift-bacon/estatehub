//
//  DashboardViewController.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import UIKit

class DashboardViewController: UIViewController {
    
    // MARK: - Enums
    
    private enum CellIdentifier: String {
        case advertCollectionViewCell = "AdvertCollectionViewCell"
        case advertTableViewCell = "AdvertTableViewCell"
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var userInfoView: UIView! {
        didSet {
            userInfoView.layer.cornerRadius = 15
            userInfoView.clipsToBounds = true
        }
    }
    @IBOutlet weak var userAvatarImageView: UIImageView! {
        didSet {
            userAvatarImageView.layer.cornerRadius = userAvatarImageView.frame.height / 2
            userAvatarImageView.contentMode = .scaleAspectFill
            userAvatarImageView.clipsToBounds = true
            
            if let user = LocalUserStorage.loadUser(), let avatar = user.avatar {
                userAvatarImageView.image = avatar
            }
        }
    }
    @IBOutlet weak var userEmailLabel: UILabel! {
        didSet {
            userEmailLabel.text = LocalUserStorage.loadUser()?.email ?? "Anonymous"
        }
    }
    @IBOutlet weak var addAdvertButton: UIButton!
    @IBOutlet weak var promotedAdvertsLabel: UILabel! {
        didSet {
            promotedAdvertsLabel.text = "Promoted Ads"
        }
    }
    @IBOutlet private(set) weak var advertsCollectionView: UICollectionView! {
        didSet {
            advertsCollectionView.dataSource = self
            advertsCollectionView.delegate = self
            advertsCollectionView.isPagingEnabled = true
            advertsCollectionView.contentInsetAdjustmentBehavior = .never
            advertsCollectionView.showsHorizontalScrollIndicator = false
            advertsCollectionView.register(AdvertCollectionViewCell.ViewConfiguration.default.nib, forCellWithReuseIdentifier: CellIdentifier.advertCollectionViewCell.rawValue)
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 8
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

            advertsCollectionView.collectionViewLayout = layout
        }
    }
    @IBOutlet weak var allAdvertsLabel: UILabel! {
        didSet {
            allAdvertsLabel.text = "Newest Ads"
        }
    }
    @IBOutlet private(set) weak var advertsTableView: UITableView! {
        didSet {
            advertsTableView.dataSource = self
            advertsTableView.delegate = self
            advertsTableView.rowHeight = UITableView.automaticDimension
            advertsTableView.register(AdvertTableViewCell.ViewConfiguration.default.nib, forCellReuseIdentifier: CellIdentifier.advertTableViewCell.rawValue)
        }
    }
    @IBOutlet weak var advertsTableViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.advertsTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.advertsTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.advertsTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.advertsTableView.layoutIfNeeded()
    }
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
    
    // MARK: - Setups
    
    private func setupLayout() {
        view.backgroundColor = .white
        title = appName
        
        setupAddAdvertButton()
        setupProfileButton()
    }
    
    ///
    /// Setup add advert button
    ///
    private func setupAddAdvertButton() {
        addAdvertButton.setTitle("Add advert", for: .normal)
        addAdvertButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .black)
        addAdvertButton.tintColor = .white
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
    
    // MARK: - Observers
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if object is UITableView {
                if let newValue = change?[.newKey] {
                    let newSize = newValue as! CGSize
                    self.advertsTableViewHeightConstraint.constant = newSize.height
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func profileButtonTapped() {
        let userProfileViewController = UserProfileViewController()
        navigationController?.pushViewController(userProfileViewController, animated: true)
    }
    
    @IBAction func addAdvertButtonDidTapped(_ sender: Any) {
        let addAdvertViewController = AddAvertViewController()
        navigationController?.pushViewController(addAdvertViewController, animated: true)
    }
    
}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.advertCollectionViewCell.rawValue, for: indexPath) as? AdvertCollectionViewCell else { return UICollectionViewCell() }
        
        cell.advertDescriptionLabel.text = "sdasdasdasdasdasd"
        cell.advertTitlaLabel.text = "dasdasdasdasd"
        cell.advertPriceLabel.text = "999 999 PLN"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.8
        let height = collectionView.frame.height - 10
        return CGSize(width: width, height: height)
    }
    
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.advertTableViewCell.rawValue, for: indexPath) as? AdvertTableViewCell else { return UITableViewCell() }
        
        cell.advertTitleLabel.text = "test"
        
        return cell
    }
    
}

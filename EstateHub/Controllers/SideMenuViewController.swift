//
//  SideMenuViewController.swift
//  EstateHub
//
//  Created by Unit27 on 04/08/2025.
//
import UIKit

protocol SideMenuDelegate: AnyObject {
    func didSelectMenuItem(_ item: SideMenuViewController.MenuItem)
}

class SideMenuViewController: UIViewController {
    
    enum MenuItem: String, CaseIterable {
        case addAdvert = "Add Advert"
        case profile = "Profile"
        case settings = "Settings"
        case logout = "Logout"
    }
    
    weak var delegate: SideMenuDelegate?
    
    private let tableView = UITableView()
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSetups()
        setupTableView()
    }
    
    //MARK: - Setups
    
    private func layoutSetups() {
        view.backgroundColor = .white
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = MenuItem.allCases[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = item.rawValue
        cell.textLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = MenuItem.allCases[indexPath.row]
        delegate?.didSelectMenuItem(selectedItem)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//
//  SettingsViewController.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import UIKit

class SettingsViewController: UIViewController {
    
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
}

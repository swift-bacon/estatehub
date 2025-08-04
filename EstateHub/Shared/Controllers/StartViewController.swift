//
//  StartViewController.swift
//  EstateHub
//
//  Created by Unit27 on 25/07/2025.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var signInButton: DefaultButton!
    @IBOutlet var signUpButton: UIButton!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
    
    // MARK: - Actions
    
    @IBAction func signInButtonDidTapped(_ sender: Any) {}
    
    @IBAction func singUpButtonDidTapped(_ sender: Any) {}
    
    // MARK: - Setups
    
    ///
    /// Setup view
    ///
    func setupView() {
        infoLabel.text = "Step into the world of real estate — find your next place."
    }

}


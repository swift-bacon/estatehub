//
//  StartViewController.swift
//  EstateHub
//
//  Created by Unit27 on 25/07/2025.
//

import UIKit

class StartViewController: UIViewController {
    
    //
    // MARK: - Outlets
    //
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var signInButton: DefaultButton!
    @IBOutlet var signUpButton: UIButton!
    
    //
    // MARK: - View did load
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    //
    // MARK: - Actions
    //
    @IBAction func signInButtonDidTapped(_ sender: Any) {
        debugPrint("test")
    }
    
    @IBAction func singUpButtonDidTapped(_ sender: Any) {
        debugPrint("test2")
    }
    
    //
    // MARK: - Setups
    //
    func setupView() {
        infoLabel.text = "Step into the world of real estate — find your next place."
    }

}


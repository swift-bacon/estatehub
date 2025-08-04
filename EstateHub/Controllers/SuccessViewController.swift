//
//  SuccessViewController.swift
//  EstateHub
//
//  Created by Unit27 on 04/08/2025.
//
import UIKit

class SuccessViewController: UIViewController {
    
    var completion: (() -> Void)?

    private let successLabel: UILabel = {
        let label = UILabel()
        label.text = "Advert successfully added!"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go to Dashboard", for: .normal)
        button.addTarget(self, action: #selector(dismissAndReturn), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }
    
    private func layout() {
        view.addSubview(successLabel)
        view.addSubview(continueButton)
        successLabel.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            successLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            continueButton.topAnchor.constraint(equalTo: successLabel.bottomAnchor, constant: 20),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func dismissAndReturn() {
        completion?()
    }
}

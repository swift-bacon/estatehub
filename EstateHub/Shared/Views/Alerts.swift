//
//  Alerts.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import UIKit

class Alerts {
    
    
    ///
    /// Show error
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - title: String
    ///   - message: String
    ///
    static func showError(on viewController: UIViewController, title: String = "Error", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        viewController.present(alert, animated: true)
    }
    
}
